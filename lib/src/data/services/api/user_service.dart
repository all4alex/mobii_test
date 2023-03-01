import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sample/src/data/models/user/user.dart';

class UserService {
  final Dio _dio;

  UserService(this._dio);
  static final String baseUrl = 'https://gist.githubusercontent.com/';

  Future<List<UserDto>> getUserList() async {
    Response response = await _dio.get(
        '${baseUrl}dustincatap/66d48847b3ca07af7cef789d6ac8fee8/raw/550798be0efa8b98f6924cfb4ad812cd290f568a/users.json');
    // The below request is the same as above.
    final List<dynamic> parsedResponse = jsonDecode(response.data);

    return parsedResponse
        .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
