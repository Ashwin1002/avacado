import 'dart:convert';

import 'package:avacado_task/common/service/network/base_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('get Post list from api', () {
    test('returns post data when http response is successful', () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call //
        final Map<String, dynamic> response = {
          "userId": 1,
          "id": 1,
          "title":
              "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body":
              "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        };
        return http.Response(jsonEncode(response), 200);
      });
      // Check whether htttp response function returns
      // bank detail as map of <String, dynamic>
      expect(await BaseClient().getResponse(baseHttp: mockHTTPClient),
          isA<Map<String, dynamic>>());
    });

    test('return error message when http response is unsuccessful', () async {
      // Mock the API call to return an
      // empty json response with http status 404
      final mockHTTPClient = MockClient((request) async {
        final response = {};
        return http.Response(jsonEncode(response), 609);
      });
      // Check whether htttp response function returns
      // error as String,
      expect(await BaseClient().getResponse(baseHttp: mockHTTPClient),
          "Data not Found.");
    });
  });
}
