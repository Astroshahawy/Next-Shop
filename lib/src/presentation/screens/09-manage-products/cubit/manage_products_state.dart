part of 'manage_products_cubit.dart';

abstract class ManageProductsState {}

class ManageProductsInitial extends ManageProductsState {}

class ProductsLoading extends ManageProductsState {}

class ProductsLoaded extends ManageProductsState {}

class ImageUploadedState extends ManageProductsState {}

class SubmitLoadingState extends ManageProductsState {}

class SubmitLoadedState extends ManageProductsState {}


