// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:aurify/core/services/player_service.dart';

// class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
//   final PlayerService _playerService = PlayerService();

//   PlayerBloc() : super(PlayerInitial()) {
//     on<PlayAudio>(_onPlayAudio);
//     on<PlayVideo>(_onPlayVideo);
//     on<PauseMedia>(_onPauseMedia);
//     on<SeekMedia>(_onSeekMedia);
//   }

//   void _onPlayAudio(PlayAudio event, Emitter<PlayerState> emit) async {
//     await _playerService.playAudio(event.filePath);
//     emit(PlayerPlaying());
//   }

//   void _onPlayVideo(PlayVideo event, Emitter<PlayerState> emit) async {
//     await _playerService.playVideo(event.filePath);
//     emit(PlayerPlaying());
//   }

//   void _onPauseMedia(PauseMedia event, Emitter<PlayerState> emit) async {
//     await _playerService.pause();
//     emit(PlayerPaused());
//   }

//   void _onSeekMedia(SeekMedia event, Emitter<PlayerState> emit) async {
//     await _playerService.seek(event.position);
//   }

//   Stream<Duration>? get positionStream => _playerService.positionStream;
//   Stream<bool> get isPlayingStream => _playerService.isPlayingStream;

//   @override
//   Future<void> close() {
//     _playerService.dispose();
//     return super.close();
//   }
// }
// //-------------------------------------------------------------------------------
// // Player Related Events
// //-------------------------------------------------------------------------------

// abstract class PlayerEvent {}

// class PlayAudio extends PlayerEvent {
//   final String filePath;
//   PlayAudio(this.filePath);
// }

// class PlayVideo extends PlayerEvent {
//   final String filePath;
//   PlayVideo(this.filePath);
// }

// class PauseMedia extends PlayerEvent {}

// class SeekMedia extends PlayerEvent {
//   final Duration position;
//   SeekMedia(this.position);
// }

// //-------------------------------------------------------------------------------
// // Player Related States
// //-------------------------------------------------------------------------------
// abstract class PlayerState {}

// class PlayerInitial extends PlayerState {}

// class PlayerPlaying extends PlayerState {}

// class PlayerPaused extends PlayerState {}
