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
    return _service.getUserList('66d48847b3ca07af7cef789d6ac8fee8',
        '550798be0efa8b98f6924cfb4ad812cd290f568a');
  }
}
