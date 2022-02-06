import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:next_shop_app/data/models/cart_product.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_state.dart';

List<CartProduct> cartProducts = <CartProduct>[];
bool productStatus = false;

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> loadCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    if (cartProducts.isEmpty) {
      if (prefs.containsKey('cart')) {
        final cartData = prefs.getString('cart');
        cartProducts = cartProductFromJson(cartData!);
      }
    }
  }

  CartProduct tryAddToCart(Product product) {
    final newProduct = CartProduct(
        id: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
        quantity: 1);

    final cartProduct = cartProducts.any((prod) => prod.id == newProduct.id)
        ? cartProducts.firstWhere((prod) => prod.id == newProduct.id)
        : newProduct;

    if (cartProducts.contains(cartProduct)) {
      productStatus = true;
    } else {
      productStatus = false;
    }
    return cartProduct;
  }

  Future<void> addToCart(CartProduct newProduct) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    cartProducts.add(newProduct);
    prefs.setString('cart', cartProductToJson(cartProducts));
  }

  bool get cartProductStatus {
    return productStatus;
  }

  Future<void> fetchCart() async {
    emit(CartLoading());
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    if (!prefs.containsKey('cart')) {
      emit(CartLoaded(cartProducts: cartProducts));
      return;
    } else {
      final cartData = prefs.getString('cart');
      cartProducts = cartProductFromJson(cartData!);
    }
    emit(CartLoaded(cartProducts: cartProducts));
  }

  double get totalCost {
    double total = 0.0;
    for (var prod in cartProducts) {
      total += prod.price * prod.quantity;
    }
    return total;
  }

  int get totalQuantity {
    int total = 0;
    for (var prod in cartProducts) {
      total += prod.quantity;
    }
    return total;
  }

  Future<void> deleteItem(CartProduct product) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    cartProducts.remove(product);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', cartProductToJson(cartProducts));
    emit(CartLoaded(cartProducts: cartProducts));
  }

  Future<void> increaseItemCount(CartProduct product) async {
    if (cartProducts.contains(product)) {
      cartProducts[cartProducts.indexOf(product)].quantity += 1;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', cartProductToJson(cartProducts));
    emit(CartLoaded(cartProducts: cartProducts));
  }

  Future<void> decreaseItemCount(CartProduct product) async {
    if (product.quantity > 1) {
      cartProducts[cartProducts.indexOf(product)].quantity -= 1;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', cartProductToJson(cartProducts));
    emit(CartLoaded(cartProducts: cartProducts));
  }

  Future<void> clearCart() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    cartProducts.clear();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', cartProductToJson(cartProducts));
    emit(CartLoaded(cartProducts: cartProducts));
  }
}
