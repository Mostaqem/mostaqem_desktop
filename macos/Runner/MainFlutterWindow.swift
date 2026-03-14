import Cocoa
import FlutterMacOS
import LaunchAtLogin
import MediaPlayer

class MainFlutterWindow: NSWindow {
  private var nowPlayingChannel: FlutterMethodChannel?
  private var playerNotifier: FlutterMethodChannel?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    FlutterMethodChannel(
        name: "launch_at_startup", binaryMessenger: flutterViewController.engine.binaryMessenger
      )
      .setMethodCallHandler { (_ call: FlutterMethodCall, result: @escaping FlutterResult) in
        switch call.method {
        case "launchAtStartupIsEnabled":
          result(LaunchAtLogin.isEnabled)
        case "launchAtStartupSetEnabled":
          if let arguments = call.arguments as? [String: Any] {
            LaunchAtLogin.isEnabled = arguments["setEnabledValue"] as! Bool
          }
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }

    // Now Playing method channel
    let nowPlaying = FlutterMethodChannel(
      name: "now_playing",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    self.nowPlayingChannel = nowPlaying

    // Channel for sending remote command events back to Flutter
    let playerChannel = FlutterMethodChannel(
      name: "now_playing_events",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )
    self.playerNotifier = playerChannel

    setupRemoteCommands()

    nowPlaying.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      guard let self = self else { return }
      switch call.method {
      case "updateMetadata":
        if let args = call.arguments as? [String: Any] {
          self.updateNowPlayingInfo(args)
        }
        result(nil)
      case "updatePlaybackState":
        if let args = call.arguments as? [String: Any] {
          self.updatePlaybackState(args)
        }
        result(nil)
      case "updatePosition":
        if let args = call.arguments as? [String: Any] {
          self.updatePosition(args)
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    RegisterGeneratedPlugins(registry: flutterViewController)
    super.awakeFromNib()
  }

  private func setupRemoteCommands() {
    let commandCenter = MPRemoteCommandCenter.shared()

    commandCenter.playCommand.isEnabled = true
    commandCenter.playCommand.addTarget { [weak self] _ in
      self?.playerNotifier?.invokeMethod("onPlay", arguments: nil)
      return .success
    }

    commandCenter.pauseCommand.isEnabled = true
    commandCenter.pauseCommand.addTarget { [weak self] _ in
      self?.playerNotifier?.invokeMethod("onPause", arguments: nil)
      return .success
    }

    commandCenter.togglePlayPauseCommand.isEnabled = true
    commandCenter.togglePlayPauseCommand.addTarget { [weak self] _ in
      self?.playerNotifier?.invokeMethod("onPlayPause", arguments: nil)
      return .success
    }

    commandCenter.nextTrackCommand.isEnabled = true
    commandCenter.nextTrackCommand.addTarget { [weak self] _ in
      self?.playerNotifier?.invokeMethod("onNext", arguments: nil)
      return .success
    }

    commandCenter.previousTrackCommand.isEnabled = true
    commandCenter.previousTrackCommand.addTarget { [weak self] _ in
      self?.playerNotifier?.invokeMethod("onPrevious", arguments: nil)
      return .success
    }

    commandCenter.changePlaybackPositionCommand.isEnabled = true
    commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
      if let positionEvent = event as? MPChangePlaybackPositionCommandEvent {
        let positionMs = Int(positionEvent.positionTime * 1000)
        self?.playerNotifier?.invokeMethod("onSeek", arguments: positionMs)
      }
      return .success
    }
  }

  private func updateNowPlayingInfo(_ args: [String: Any]) {
    var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]

    if let title = args["title"] as? String {
      nowPlayingInfo[MPMediaItemPropertyTitle] = title
    }
    if let artist = args["artist"] as? String {
      nowPlayingInfo[MPMediaItemPropertyArtist] = artist
    }
    if let durationMs = args["duration"] as? Int {
      nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = Double(durationMs) / 1000.0
    }

    if let artworkUrl = args["artworkUrl"] as? String, let url = URL(string: artworkUrl) {
      DispatchQueue.global(qos: .userInitiated).async {
        if let data = try? Data(contentsOf: url), let image = NSImage(data: data) {
          let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
          DispatchQueue.main.async {
            var info = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
            info[MPMediaItemPropertyArtwork] = artwork
            MPNowPlayingInfoCenter.default().nowPlayingInfo = info
          }
        }
      }
    }

    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }

  private func updatePlaybackState(_ args: [String: Any]) {
    let isPlaying = args["isPlaying"] as? Bool ?? false
    MPNowPlayingInfoCenter.default().playbackState = isPlaying ? .playing : .paused
  }

  private func updatePosition(_ args: [String: Any]) {
    var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]

    if let positionMs = args["position"] as? Int {
      nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Double(positionMs) / 1000.0
    }
    if let durationMs = args["duration"] as? Int {
      nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = Double(durationMs) / 1000.0
    }
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0

    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
}
