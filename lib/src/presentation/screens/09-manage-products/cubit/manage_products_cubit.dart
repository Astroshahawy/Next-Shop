import 'dart:io';

import 'package:next_shop_app/src/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/src/data/repository/repository.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  final ApiRepository _apiRepository;

  ManageProductsCubit(
    this._apiRepository,
  ) : super(ManageProductsInitial());

  static ManageProductsCubit get(context) =>
      BlocProvider.of<ManageProductsCubit>(context);

  List<Product> products = [];

  Future<void> getProducts() async {
    emit(ProductsLoading());
    products = await _apiRepository.getProducts();
    emit(ProductsLoaded());
  }

  Future<void> deleteProduct(int id) async {
    await _apiRepository.deleteProduct(id: id);
    products.removeWhere((item) => item.id == id);
    emit(ProductsLoaded());
  }

  final List<String> categories = [
    'electronics',
    'jewelery',
    'men\'s clothing',
    'women\'s clothing',
  ];

  Future<void> editProduct(Product product) async {
    emit(SubmitLoadingState());
    await _apiRepository.editProduct(
      id: product.id,
      title: productTitleController.text.trim(),
      price: double.parse(productPriceController.text.trim()),
      description: productDescriptionController.text.trim(),
      image: productImage.path.isEmpty ? product.image : productImage.path,
      category: categoryValue!,
    );
    emit(SubmitLoadedState());
  }

  Future<void> addProduct() async {
    emit(SubmitLoadingState());
    await _apiRepository.addProduct(
      title: productTitleController.text.trim(),
      price: double.parse(productPriceController.text.trim()),
      description: productDescriptionController.text.trim(),
      image: productImage.path,
      category: categoryValue!,
    );
    emit(SubmitLoadedState());
  }

  File productImage = File('');
  bool imageUploaded = false;

  void saveImage(File image) {
    productImage = image;
    imageUploaded = true;
    emit(ImageUploadedState());
  }

  void clear() {
    imageUploaded = false;
    productTitleController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    categoryValue = '';
    emit(ManageProductsInitial());
  }

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  String? categoryValue = '';

  void fetchProductInfo(Product product) {
    productTitleController.text = product.title;
    productPriceController.text = product.price.toStringAsFixed(2);
    productDescriptionController.text = product.description;
    categoryValue = product.category;
  }
}
