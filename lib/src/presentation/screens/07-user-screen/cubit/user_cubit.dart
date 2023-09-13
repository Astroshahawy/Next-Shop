import 'package:next_shop_app/core/utils/title_capitalization.dart';
import 'package:next_shop_app/src/data/models/user.dart';
import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

String _username = '';

class UserCubit extends Cubit<UserState> {
  final ApiRepository _apiRepository;
  UserCubit(
    this._apiRepository,
  ) : super(UserInitial());

  Future<void> getUserProfile() async {
    emit(UserLoading());
    final user = await _apiRepository.getUserProfile();
    emit(UserLoaded(user: user));
  }

  String get username => _username;

  Future<bool> userAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getDrawerBasicInfo() async {
    final auth = await userAuth();
    if (auth) {
      final user = await _apiRepository.getUserProfile();
      _username =
          titleCapitalize('${user.name.firstname} ${user.name.lastname}');
    }
  }

  Future<void> checkUserAuth(bool auth) async {
    if (auth) {
      getUserProfile();
    } else {
      emit(UserNotAuth());
    }
  }
}
