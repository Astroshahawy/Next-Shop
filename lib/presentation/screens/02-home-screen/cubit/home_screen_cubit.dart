import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/data/repositories/repository.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final ApiRepository _apiRepository;

  HomeScreenCubit(
    this._apiRepository,
  ) : super(HomeScreenInitial());

  Future<void> getHomeData() async {
    emit(HomeScreenLoading());
    final products = await _apiRepository.getProducts();
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
}
