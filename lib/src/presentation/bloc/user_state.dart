part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  UserSuccess({required this.userList});
  final List<UserDto> userList;
}

class UserError extends UserState {
  UserError({required this.error});
  final String error;
}
