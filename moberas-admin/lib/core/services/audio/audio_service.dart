import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:injectable/injectable.dart';

@singleton
class AudioService {
  final assetsAudioPlayer = AssetsAudioPlayer();

  Future<void> milestoneBoxClick() async => await assetsAudioPlayer.open(Audio('assets/audio/click_keyboard.mp3'), autoStart: true, playInBackground: PlayInBackground.enabled, volume: 1.0, respectSilentMode: false);

  Future<void> buttonClick() async => await assetsAudioPlayer.open(Audio('assets/audio/click_keyboard.mp3'), autoStart: true, playInBackground: PlayInBackground.enabled, volume: 1.0, respectSilentMode: false);

  Future<void> answered() async {
    return await assetsAudioPlayer.open(Audio('assets/audio/jump.wav'),
        autoStart: true, showNotification: false, playInBackground: PlayInBackground.enabled, volume: 0.2, respectSilentMode: false);
  }

  Future<void> taskCompleted() async {
    return await assetsAudioPlayer.open(Audio('assets/audio/taskComplete.wav'), autoStart: true, playInBackground: PlayInBackground.enabled, volume: 1.0, respectSilentMode: false);
  }

  Future<void> taskIni() async {
    return await assetsAudioPlayer.open(Audio('assets/audio/meeting.wav'),
        autoStart: true, playInBackground: PlayInBackground.enabled, volume: 0.2, respectSilentMode: false, loopMode: LoopMode.single);
  }

  Future<void> open() async {
    return await assetsAudioPlayer.open(Audio('assets/audio/open.wav'), autoStart: true, playInBackground: PlayInBackground.enabled, volume: 0.6, respectSilentMode: false);
  }

  Future<void> close() async {
    return await assetsAudioPlayer.open(Audio('assets/audio/close.wav'), autoStart: true, playInBackground: PlayInBackground.enabled, volume: 1.0, respectSilentMode: false);
  }

  Future<void> stop() async {
    return await assetsAudioPlayer.stop();
  }
  
}
