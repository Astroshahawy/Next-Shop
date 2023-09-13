part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;
  final List<Product> allProducts;
  OrdersLoaded({
    required this.orders,
    required this.allProducts,
  });
}

class OrdersAuth extends OrdersState {}

class OrdersNotAuth extends OrdersState {}