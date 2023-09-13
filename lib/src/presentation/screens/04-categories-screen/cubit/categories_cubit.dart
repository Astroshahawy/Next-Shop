import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
