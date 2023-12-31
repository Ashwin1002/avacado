import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'app_response.dart';
import 'exceptions/app_exception.dart';

const String _baseUrl = "jsonplaceholder.typicode.com";

const int _timeoutDuration = 10000;

class BaseClient {
  ///Get Request
  Future<dynamic> getResponse({
    required http.Client baseHttp,
    String? endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri uri = Uri(
      scheme: "https",
      host: _baseUrl,
      path: endPoint,
      queryParameters: queryParameters,
    );

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (kDebugMode) {
      log("get request => ${uri.toString()}");
    }
    try {
      var response = await baseHttp
          .get(uri, headers: header)
          .timeout(const Duration(seconds: _timeoutDuration));
      return AppResponse.processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection", uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          "API not responded in time", uri.toString());
    }
  }
}
