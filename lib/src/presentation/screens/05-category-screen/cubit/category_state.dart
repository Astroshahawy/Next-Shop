part of 'category_cubit.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class LoadingState extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Product> products;
  CategoryLoaded({
    required this.products,
  });
}