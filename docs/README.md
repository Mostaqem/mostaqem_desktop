> We thank you for contribution to Mostaqem , and may Allah reward you (جزاك الله خيرا)

## Get Started
* **Download** the latest [Flutter](https://docs.flutter.dev/get-started/install) version, Mostaqem keeps up to date with latest dart and flutter version
* **Fork** the Repository
* **Install** Mostaqem dependencies using `flutter pub get`, Make sure `mpv` and `libmpv-dev` are installed for Linux platforms if you are going to program on Linux distros
* Simply Run the app using `flutter run --dart-define-from-file dev.env`

**Note**: 
- I've added `dev.env` as a development environment example to use so you can just get started
- Make sure your IDE runs the program with the `dev.env` otherwise you can start running Mostaqem through this command 
`flutter run --dart-define-from-file dev.env` in order for the variables to work

## Guidelines
* Make sure you follow [Mostaqem Guidelines](CONTRIBUTING)


## Project Structure
```
├── analysis_options.yaml                          # analysis files
├── assets                                         # includes imgs , json                 
├── dev.env                                        # development environment
├── dmg-creator                                    # creating dmg file script for building macos
|
├── docs                                           # documentation 
|
├── lib                                 
│   ├── main.dart                                  # Main file
│   └── src
│       ├── app.dart
│       ├── core
│       │   ├── dio                                # dio requests config
│       │   ├── discord                            # discord rich precense
│       │   ├── env                                # environment variables
│       │   ├── logger                             # proivider logger
│       │   ├── mpris                              # mpris for linux dbus
│       │   ├── routes                             # navigation routes
│       │   ├── screens                            # navigation bar screens
│       │   ├── SMTC                               # windows SMTC
│       │   └── theme                              # Theme config
│       ├── screens
│       │   ├── fullscreen
│       │   │   ├── full_screen.dart               # fullscreen UI
│       │   │   ├── providers                      # fullscreen riverpod provider
│       │   │   └── widgets                        # repeated widgets in fullscreen
│       │   ├── home                               # home screen UI
│       │   │   ├── data                           # freezed files 
│       │   │   │   ├── surah.dart
│       │   │   │   ├── surah.freezed.dart
│       │   │   │   └── surah.g.dart
│       │   │   ├── home_screen.dart               # homescreen UI
│       │   │   ├── providers                      # providers used in homescreen
│       │   │   │   ├── home_providers.dart
│       │   │   │   └── home_providers.g.dart
│       │   │   └── widgets                        # repeated widgets
│       │   │       ├── hijri_date_widget.dart
│       │   │       ├── queue_widget.dart
│       │   │       └── surah_widget.dart
│       │   ├── initial                            # initial loading screen
│       │   │   ├── data                           
│       │   │   │   └── loading_verse.dart         # random verses
│       │   │   └── inital_loading.dart
│       │   ├── navigation                         # navigation bar widget
│       │   │   ├── data                           # freezed files
│       │   │
│       │   │   ├── navigation.dart                # navigation bar widget
│       │   │   ├── repository                     # player repository and riverpod providers
│       │   │   └── widgets                      # player widgets
│       │   │       ├── player
│       │   │       │   ├── download_manager.dart       # download manger UI
│       │   │       │   ├── normal_player.dart          # Full player widgets without fittedbox
│       │   │       │   ├── play_controls.dart          # player controls widget
│       │   │       │   ├── player_widget.dart          # Full player widget with Fittedbox for responsive on lower screen
│       │   │       │   ├── playing_surah.dart          # Current playing surah and reciter widget
│       │   │       │   ├── recitation_widget.dart      # recitation widget
│       │   │       │   └── volume_control.dart         # volume widget
│       │   │       ├── providers
│       │   │       │   └── playing_provider.dart     # current playing provider
│       │   │       └── squiggly                    # squiggly ui player
│       │   ├── offline                        
│       │   │   ├── offline.dart                  # offline ui
│       │   │   └── repository
│       │   │       └── offline_repository.dart
│       │   ├── queue                             # queue ui
│       │   │   └── presentation
│       │   │       └── queue_screen.dart
│       │   ├── reading                           # reading ui
│       │   │   ├── data                          # freezed file
│       │   │   ├── providers
│       │   │   └── reading_screen.dart
│       │   ├── reciters                          
│       │   │   ├── data                          # freezed files
│       │   │   ├── providers                     # providers used in reciter screen
│       │   │   └── reciters_screen.dart          # reciters screen
│       │   └── settings                          
│       │       ├── appearance
│       │       │   ├── apperance.dart             # apperance option
│       │       │   └── providers                  # apperance riverpod providers    
│       │       ├── download                       # download option
│       │       │   └── download_options.dart
│       │       ├── providers                      # download riverpod providers
│       │       ├── settings_screen.dart         # settings screen
│       │       └── startup                      # startup option
│       │           ├── provider
│       │           ├── startup_options.dart
│       │           └── startup_state.dart
│       └── shared                               # common shared files
│           ├── cache                            # helper class for cache
│           ├── device                           # helper class for device info
│           ├── http_override                    # enable https 
│           ├── internet_checker                 # checks internet connection
│           └── widgets                          # common widgets
│         ...
│               ├── shortcuts                    # shortcuts
│            ...
|
├── LICENSE                                      # App license                                    
|
├── linux                                        # Linux configuration
|
├── macos                                        # macos configuration
|
├── Mostaqem-Inno.iss                            # Inno setup configuration for building the .exe setup file
|
├── POLICY.md                                    # privacy policy
├── pubspec.lock                
├── pubspec.yaml                                 # flutter dependencies
├── README.md                                    # original readme file
├── screenshots                                  # screenshots
└── windows                                      # windows configurations            
```





