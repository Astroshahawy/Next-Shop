class AppRoutes {
  static const String initRoute = '/';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String allProductsScreen = '/all_products_screen';
  static const String productScreen = '/product_screen';
  static const String allCategoriesScreen = '/all_categories_screen';
  static const String categoryScreen = '/category_screen';
  static const String cartScreen = '/cart_screen';
  static const String ordersScreen = '/orders_screen';
  static const String userScreen = '/user_screen';
  static const String manageProductsScreen = '/manage_products_screen';
  static const String addProductScreen = '/add_product_screen';
}

class AppApis {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String authEP = '/auth/login';
  static const String registerEP = '/users';
  static const String productsEP = '/products';
  static const String allCategoriesEP = '/products/categories';
  static const String categoryEP = '/products/category/';
  static const String ordersEP = '/carts/user/1';
  static const String userEP = '/users/1';
  static const String limitEP = '?limit=';
}
