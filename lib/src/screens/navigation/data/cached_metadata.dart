import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';

import 'package:mostaqem/src/screens/home/data/surah.dart';

class CachedAudioMetadata {
  CachedAudioMetadata({
    required this.surah,
    required this.reciter,
    required this.audioUrl,
  });

  // Create from JSON
  factory CachedAudioMetadata.fromJson(Map<String, dynamic> json) {
    return CachedAudioMetadata(
      surah: Surah.fromJson(json['surah'] as Map<String, dynamic>),
      reciter: Reciter.fromJson(json['reciter'] as Map<String, dynamic>),
      audioUrl: json['audioUrl'] as String,
    );
  }
  final Surah surah;
  final Reciter reciter;
  final String audioUrl;

  // Convert to JSON for easy storage
  Map<String, dynamic> toJson() => {
        'surah': surah,
        'reciter': reciter,
        'audioUrl': audioUrl,
      };
}
