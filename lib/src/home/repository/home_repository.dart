import 'package:avacado_task/common/service/network/base_client.dart';
import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:http/http.dart' as http;

final BaseClient _baseClient = BaseClient();

class HomeRepository {
  Future<List<PostModel>> getPosts(
      {int startIndex = 0, int postLimit = 20}) async {
    final response = await _baseClient.getResponse(
      baseHttp: http.Client(),
      endPoint: "posts",
      queryParameters: {'_start': '$startIndex', '_limit': '$postLimit'},
    );
    if (response case final response?) {
      final body = response as List;
      return body.map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
