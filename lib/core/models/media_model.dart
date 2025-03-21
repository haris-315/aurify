// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Media {
  final String title;
  final String path;
  final String artist;
  final String album;
  final Uint8List? thumbnail;
  final Duration duration;
  Media({
    required this.title,
    required this.path,
    required this.artist,
    required this.album,
    this.thumbnail,
    required this.duration,
  });


  Media copyWith({
    String? title,
    String? path,
    String? artist,
    String? album,
    Uint8List? thumbnail,
    Duration? duration,
  }) {
    return Media(
      title: title ?? this.title,
      path: path ?? this.path,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'path': path,
      'artist': artist,
      'album': album,
      'thumbnail': thumbnail,
      'duration': duration.toString(),
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      title: map['title'] as String,
      path: map['path'] as String,
      artist: map['artist'] as String,
      album: map['album'] as String,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as Uint8List : null,
      duration: Duration(milliseconds: int.parse(map['duration'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Media(title: $title, path: $path, artist: $artist, album: $album, thumbnail: $thumbnail, duration: $duration)';
  }

  @override
  bool operator ==(covariant Media other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.path == path &&
      other.artist == artist &&
      other.album == album &&
      other.thumbnail == thumbnail &&
      other.duration == duration;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      path.hashCode ^
      artist.hashCode ^
      album.hashCode ^
      thumbnail.hashCode ^
      duration.hashCode;
  }
}
