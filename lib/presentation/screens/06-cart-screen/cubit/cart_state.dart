part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartProduct> cartProducts;
  CartLoaded({
    required this.cartProducts,
  });
}
