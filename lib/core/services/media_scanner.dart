import 'dart:io';
import 'package:aurify/core/models/media_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaScanner {
  Future<List<Media>> scanMediaFiles() async {
    List<Media> mediaFiles = [];
    Directory? directory = await getExternalStorageDirectory();

    if (directory != null) {
      mediaFiles = await _scanDirectory(directory);
    }

    return mediaFiles;
  }

  Future<List<Media>> _scanDirectory(Directory directory) async {
    List<Media> mediaFiles = [];

    try {
      await for (var entity in directory.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is File) {
          String path = entity.path;
          if (_isMediaFile(path)) {
            mediaFiles.add(await _getMediaMetadata(entity));
          }
        }
      }
    } catch (e) {
      print('Error scanning directory: $e');
    }

    return mediaFiles;
  }

  bool _isMediaFile(String path) {
    List<String> mediaExtensions = [
      '.mp3',
      '.wav',
      '.aac',
      '.flac',
      '.mp4',
      '.mkv',
      '.avi',
      '.mov',
    ];
    String extension = path.substring(path.lastIndexOf('.')).toLowerCase();
    return mediaExtensions.contains(extension);
  }

  Future<Media> _getMediaMetadata(File file) async {
    try {
      Metadata metadata = await MetadataRetriever.fromFile(file);
      String? thumbnailPath;
      if (file.path.endsWith('.mp4') || file.path.endsWith('.mkv')) {
        thumbnailPath = await VideoThumbnail.thumbnailFile(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 120,
          quality: 50,
        );
      }
      return Media(
        title: metadata.trackName ?? file.path.split('/').last,
        artist: metadata.trackArtistNames?.join(', ') ?? 'Unknown',
        album: metadata.albumName ?? 'Unknown',
        duration: Duration(milliseconds: metadata.trackDuration ?? 0),
        path: file.path,
        thumbnail: thumbnailPath,
      );
    } catch (e) {
      return Media(
        title: file.path.split('/').last,
        artist: 'Unknown',
        album: 'Unknown',
        duration: Duration.zero,
        path: file.path,
        thumbnail: null,
      );
    }
  }
}
