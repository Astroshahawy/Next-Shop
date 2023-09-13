import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/src/data/models/orders.dart';
import 'package:next_shop_app/src/data/models/product.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final ApiRepository _apiRepository;
  OrdersCubit(
    this._apiRepository,
  ) : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());
    final orders = await _apiRepository.getOrders();
    final products = await _apiRepository.getProducts();
    emit(OrdersLoaded(orders: orders, allProducts: products));
  }

  List<Product> getProducts({
    required List<OrderProducts> prods,
    required List<Product> products,
  }) {
    final newList = <Product>[];

    for (var prod in prods) {
      newList.add(products.elementAt(prod.productId));
    }

    return newList;
  }
}
