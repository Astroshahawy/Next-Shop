import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ApiRepository _apiRepository;
  CategoryCubit(
    this._apiRepository,
  ) : super(CategoryInitial());

  final List<String> dropdown = [
    'Standard',
    'Price: Low to High',
    'Price: High to Low'
  ];

  List<Product> products = [];

  int initPageLimit = 8;
  int limitOffset = 0;
  bool isFirstFetch = false;
  bool isLoading = false;
  bool isAllProducts = true;

  Future<void> getCategory(String category) async {
    if (category == 'all products') {
      isAllProducts = true;
      limitOffset = 0;
      isFirstFetch = true;
      emit(CategoryLoading());
      products = await _apiRepository.getLimitedProducts(initPageLimit);
      emit(CategoryLoaded(products: products));
      isFirstFetch = false;
    } else {
      isAllProducts = false;
      isFirstFetch = true;
      emit(CategoryLoading());
      products = await _apiRepository.getSingleCategory(category)
        ..shuffle();
      emit(CategoryLoaded(products: products));
      isFirstFetch = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoading) return;
    toggleIsLoading(true);
    emit(CategoryLoading());
    limitOffset += 4;
    await _apiRepository
        .getLimitedProducts(initPageLimit + limitOffset)
        .then((value) {
      isFirstFetch = false;
      products = value;
      toggleIsLoading(false);
      emit(CategoryLoaded(products: products));
    });
  }

  void sortItems(String value) {
    switch (value) {
      case 'Standard':
        products.sort((a, b) => a.id.compareTo(b.id));
        emit(CategoryLoaded(products: products));
        break;
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        emit(CategoryLoaded(products: products));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        emit(CategoryLoaded(products: products));
        break;
    }
  }

  toggleIsLoading(bool flag) {
    isLoading = flag;
    emit(LoadingState());
  }
}
