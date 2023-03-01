import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'package:sample/src/data/models/user/user.dart';

@RestApi(baseUrl: 'https://gist.githubusercontent.com/')
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @GET('dustincatap/{someId}/raw/{anotherI d}/users.json')
  Future<List<UserDto>> getUserList(
    @Path('someId') String someId,
    @Path('anotherId') String anotherId,
  );
}

class _UserService implements UserService {
  _UserService(this._dio) {
    baseUrl ??= 'https://gist.githubusercontent.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<UserDto>> getUserList(someId, anotherId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, 'dustincatap/$someId/raw/$anotherId/users.json',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    print('asdsads::: ${_result.data.runtimeType}');

    final parsedData = jsonDecode(_result.data);

    for (int x = 0; x < parsedData!.length; x++) {
      print('xxxx: ${parsedData[x]}');
    }
    print('sdgdfgfdgdf::: ${parsedData.runtimeType}');

    final value = parsedData.map((i) {
      print('iiiiii::: $i');
    });
    // final _result = await _dio.get(path)<String>(_setStreamType<List<UserDto>>(
    //     Options(method: 'GET', headers: _headers, extra: _extra)
    //         .compose(
    //             _dio.options, 'dustincatap/$someId/raw/$anotherId/users.json',
    //             queryParameters: queryParameters, data: _data)
    //         .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    // print('TEST ${_result.data.runtimeType}');
    // final dynamic parsedData = jsonDecode(_result.data!);
    // var value = parsedData
    //     .map((dynamic i) => UserDto.fromJson(i as Map<String, dynamic>))
    //     .toList();

    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    print('TTTT: $T');
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
