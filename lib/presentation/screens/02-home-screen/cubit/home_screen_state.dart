part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Product> carouselProducts;
  final List<Product> featuredProducts;
  final List<Product> newProducts;
  final List<String> categories;
  HomeScreenLoaded({
    required this.carouselProducts,
    required this.featuredProducts,
    required this.newProducts,
    required this.categories,
  });

}
