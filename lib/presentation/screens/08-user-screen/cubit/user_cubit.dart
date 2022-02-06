import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:next_shop_app/data/models/user.dart';
import 'package:next_shop_app/data/repositories/repository.dart';
import 'package:next_shop_app/helpers/title_capitalization.dart';

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

  Future<void> getDrawerBasicInfo() async {
    final user = await _apiRepository.getUserProfile();
    _username = titleCapitalize('${user.name.firstname} ${user.name.lastname}');
  }

  Future<void> checkUserAuth(bool auth) async {
    if (auth) {
      getUserProfile();
    } else {
      emit(UserNotAuth());
    }
  }
}
