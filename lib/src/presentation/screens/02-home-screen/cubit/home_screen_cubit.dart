import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final ApiRepository _apiRepository;

  HomeScreenCubit(
    this._apiRepository,
  ) : super(HomeScreenInitial());

  List<Product> products = [];

  Future<void> getHomeData() async {
    emit(HomeScreenLoading());
    products = await _apiRepository.getProducts();
    final categories = await _apiRepository.getAllCategories();
    final carouselShuffledProducts = products.toList()..shuffle();
    final featuredShuffledProducts = products.toList()..shuffle();
    final newShuffledProducts = products.toList()..shuffle();
    final carouselProducts = carouselShuffledProducts.take(5).toList();
    final featuredProducts = featuredShuffledProducts.take(6).toList();
    final newProducts = newShuffledProducts.take(4).toList();
    emit(HomeScreenLoaded(
      carouselProducts: carouselProducts,
      featuredProducts: featuredProducts,
      newProducts: newProducts,
      categories: categories.cast<String>(),
    ));
  }

  Future<List<Product>> searchProduct(String product) async {
    return product.trim().isEmpty
        ? []
        : products
            .where((element) =>
                element.title.toLowerCase().contains(product.toLowerCase()))
            .toList();
  }
}
