import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/data/repositories/repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ApiRepository _apiRepository;
  CategoryCubit(
    this._apiRepository,
  ) : super(CategoryInitial());

  Future<void> getCategory(String category) async {
    emit(CategoryLoading());
    final List<Product> product;
    if (category == 'all products') {
      product = await _apiRepository.getProducts()
        ..shuffle();
    } else {
      product = await _apiRepository.getSingleCategory(category);
    }
    emit(CategoryLoaded(products: product));
  }
}
