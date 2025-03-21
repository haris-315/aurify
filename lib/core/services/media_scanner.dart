import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:aurify/core/models/media_model.dart';

class MediaScanner {
  Future<List<Media>> scanMediaFiles() async {
    // Let the user pick a folder
    Directory? directory = await _pickFolder();
    if (directory == null) {
      return [];
    }

    // Scan the directory and get media files
    List<Media> mediaFiles = await _scanDirectory(directory);
    return mediaFiles;
  }

  // Use FilePicker to let the user pick a directory
  Future<Directory?> _pickFolder() async {
    // Request storage permission first
    await requestPermissions();

    // Pick a folder from the file system
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      return Directory(result); // Return the folder path as a Directory object
    }

    return null; // If no folder selected
  }

  // Request storage permission
  Future<void> requestPermissions() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      // Permissions granted
    } else {
      // Handle permission denied
      print('Storage permission denied');
    }
  }

  // Scan the directory for media files
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

  // Check if the file is a valid media file (audio/video)
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

  // Get metadata of a media file (title, artist, album, duration, thumbnail)
  Future<Media> _getMediaMetadata(File file) async {
    try {
      var metadata = await MetadataGod.readMetadata(file: file.path);

      return Media(
        title: metadata.title ?? file.path.split('/').last,
        artist: metadata.artist ?? 'Unknown',
        album: metadata.album ?? 'Unknown',
        duration:
            metadata.duration != null
                ? Duration(milliseconds: metadata.duration!.inMilliseconds)
                : Duration.zero,
        path: file.path,
        thumbnail: metadata.picture?.data,
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
