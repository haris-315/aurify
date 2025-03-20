// import 'package:just_audio/just_audio.dart';
// import 'package:video_player/video_player.dart';

// class PlayerService {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   VideoPlayerController? _videoController;

//   Future<void> playAudio(String filePath) async {
//     await _audioPlayer.setFilePath(filePath);
//     _audioPlayer.play();
//   }

//   Future<void> playVideo(String filePath) async {
//     _videoController = VideoPlayerController.file(File(filePath));
//     await _videoController!.initialize();
//     _videoController!.play();
//   }

//   Future<void> pause() async {
//     if (_videoController != null) {
//       await _videoController!.pause();
//     } else {
//       await _audioPlayer.pause();
//     }
//   }

//   Future<void> seek(Duration position) async {
//     if (_videoController != null) {
//       await _videoController!.seekTo(position);
//     } else {
//       await _audioPlayer.seek(position);
//     }
//   }

//   Stream<Duration>? get positionStream {
//     if (_videoController != null) {
//       return _videoController!.position.asStream();
//     } else {
//       return _audioPlayer.positionStream;
//     }
//   }

//   Stream<bool> get isPlayingStream {
//     if (_videoController != null) {
//       return _videoController!.value.isPlaying.asStream();
//     } else {
//       return _audioPlayer.playerStateStream.map((state) => state.playing);
//     }
//   }

//   void dispose() {
//     _audioPlayer.dispose();
//     _videoController?.dispose();
//   }
// }
