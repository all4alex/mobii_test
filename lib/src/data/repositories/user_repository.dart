import 'package:dio/dio.dart';
import 'package:sample/src/app/utils/api_interceptor.dart';
import 'package:sample/src/data/models/user/user.dart';
import 'package:sample/src/data/services/api/user_service.dart';

abstract class UserRepository {
  Future<List<UserDto>> getUserList();
}

class UserRepositoryImpl extends UserRepository {
  final UserService _service =
      UserService(Dio()..interceptors.add(ApiInterceptor()));

  @override
  Future<List<UserDto>> getUserList() {
    return _service.getUserList();
  }
}
