import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample/src/data/models/user/user.dart';
import 'package:sample/src/data/repositories/user_repository.dart';
import 'package:sample/src/data/services/api/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(UserInitial());

  final UserRepository userRepository;

  Future<void> getUsers() async {
    emit(UserLoading());
    try {
      final List<UserDto> data = await userRepository.getUserList();

      print('TESTINGG: ${data.toString()}');
      emit(UserSuccess(userList: data));
    } catch (e) {
      print('TESTINGG: $e');
      emit(UserError(error: '$e'));
    }
  }
}
