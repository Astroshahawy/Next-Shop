import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:next_shop_app/data/repositories/repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final ApiRepository _apiRepository;
  CategoriesCubit(
    this._apiRepository,
  ) : super(CategoriesInitial());

  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    final categories = await _apiRepository.getAllCategories();
    emit(CategoriesLoaded(categories: categories.cast<String>()));
  }
}
