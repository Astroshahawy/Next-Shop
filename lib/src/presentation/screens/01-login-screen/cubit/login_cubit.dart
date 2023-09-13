import 'dart:convert';

import 'package:next_shop_app/src/data/models/user.dart';
import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

bool _userAuth = false;

class LoginCubit extends Cubit<LoginState> {
  final ApiRepository _apiRepository;
  LoginCubit(
    this._apiRepository,
  ) : super(LoginInitial());

  Future<void> login(
      {required String userName, required String password}) async {
    emit(LoginProcessing());
    final token =
        await _apiRepository.login(userName: userName, password: password);
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'username': userName,
      'password': password,
    });
    final userToken = json.encode({
      'token': token,
    });
    prefs.setString('userData', userData);
    prefs.setString('token', userToken);
  }

  Future<void> register(
      {required String userName,
      required String password,
      required String userEmail}) async {
    emit(RegisterProcessing());
    await _apiRepository.register(
        userName: userName, password: password, userEmail: userEmail);
    emit(RegisterCompleted());
  }

  bool get userAuthStatus => _userAuth;

  Future<void> userAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _userAuth = true;
    } else {
      _userAuth = false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(
        const Duration(seconds: 1), () => prefs.remove('token'));
  }

  Future<UserLoginData> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final userData = json.decode(prefs.getString('userData')!);
      return UserLoginData.fromMap(userData);
    } else {
      return UserLoginData(username: '', password: '');
    }
  }

  Future<void> tryGetUserData() async {
    emit(UserDataLoading());
    final data =
        await Future.delayed(const Duration(seconds: 1), () => getUserData());
    emit(UserDataLoaded(username: data.username, password: data.password));
  }
}
