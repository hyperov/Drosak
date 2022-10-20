import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'create_video_res.freezed.dart';
part 'create_video_res.g.dart';

@freezed
abstract class CreateVideoRes with _$CreateVideoRes {
  const factory CreateVideoRes({
    required int videoLibraryId,
    required String guid,
    required String title,
    required DateTime dateUploaded,
    required int views,
    required bool isPublic,
    required int length,
    required int status,
    required int framerate,
    required int width,
    required int height,
    required dynamic availableResolutions,
    required int thumbnailCount,
    required int encodeProgress,
    required int storageSize,
    required List<dynamic> captions,
    bool? hasMp4Fallback,
    required String collectionId,
    required String thumbnailFileName,
    required int averageWatchTime,
    required int totalWatchTime,
    required String category,
    required List<dynamic> chapters,
    required List<dynamic> moments,
    required List<dynamic> metaTags,
  }) = _CreateVideoRes;

  factory CreateVideoRes.fromJson(Map<String, dynamic> json) =>
      _$CreateVideoResFromJson(json);
}
