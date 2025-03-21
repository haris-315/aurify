import 'package:aurify/core/models/media_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aurify/core/services/media_scanner.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaScanner _mediaScanner = MediaScanner();

  MediaBloc() : super(MediaInitial()) {
    on<ScanMedia>(_onScanMedia);
  }

  void _onScanMedia(ScanMedia event, Emitter<MediaState> emit) async {
    print('scan started');
    emit(MediaLoading());
    try {
      List<Media> mediaFiles = await _mediaScanner.scanMediaFiles();
      emit(MediaLoaded(mediaFiles));
      print(mediaFiles);
    } catch (e) {
      print('scan completed');
      emit(MediaError('Failed to scan media files: $e'));
    }
  }
}

//-------------------------------------------------------------------------------
// Media Related Events
//-------------------------------------------------------------------------------
abstract class MediaEvent {}

class ScanMedia extends MediaEvent {}

//-------------------------------------------------------------------------------
// Media Related States
//-------------------------------------------------------------------------------
abstract class MediaState {}

class MediaInitial extends MediaState {}

class MediaLoading extends MediaState {}

class MediaLoaded extends MediaState {
  final List<Media> mediaFiles;
  MediaLoaded(this.mediaFiles);
}

class MediaError extends MediaState {
  final String message;
  MediaError(this.message);
}
