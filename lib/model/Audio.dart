import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioService {
  FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();
  PlayerState _audioPlayerState = PlayerState.isStopped;

  Future<void> playAudio(String audioUrl) async {
    await _soundPlayer.openAudioSession();
    if (audioUrl.contains("http")) {
      await _soundPlayer.startPlayer(
        fromURI: audioUrl,
        codec: Codec.mp3,
      );
    } else {
      await _soundPlayer.startPlayer(
        fromDataBuffer: (await rootBundle.load(audioUrl)).buffer.asUint8List(),
      );
    }
    _audioPlayerState = PlayerState.isPlaying;
  }

  Future<void> stopAudio() async {
    await _soundPlayer.stopPlayer();
    _audioPlayerState = PlayerState.isStopped;
  }

  PlayerState get audioPlayerState => _audioPlayerState;

  void dispose() {
    _soundPlayer.stopPlayer();
    _soundPlayer.closeAudioSession();
  }
}
