import 'package:dio/dio.dart';
import 'package:drosak/videos/model/entity/create_video_body.dart';
import 'package:drosak/videos/model/entity/create_video_res.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static const String _base = "https://video.bunnycdn.com/library/";
  static const String videoLibraryId = "65386";
  static const String AccessKey = "1886312d-16fb-4c3b-a91acc4328a8-22c0-4460";
  static const String baseUrl = "$_base$videoLibraryId";

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/videos')
  Future<CreateVideoRes> createVideoObj(@Body() CreateVideoBody body);
}
