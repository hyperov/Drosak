import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_video_body.freezed.dart';

part 'create_video_body.g.dart';

@freezed
abstract class CreateVideoBody with _$CreateVideoBody {
  const factory CreateVideoBody({
    required String title,
    String? collectionId,
  }) = _CreateVideoBody;

  factory CreateVideoBody.fromJson(Map<String, dynamic> json) =>
      _$CreateVideoBodyFromJson(json);
}
