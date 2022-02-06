part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserDataLoading extends LoginState {}

class UserDataLoaded extends LoginState {
  final String username;
  final String password;
  UserDataLoaded({
    required this.username,
    required this.password,
  });
}

class LoginProccessing extends LoginState {}