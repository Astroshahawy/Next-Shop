import 'package:next_shop_app/core/network/dio_helper.dart';
import 'package:next_shop_app/src/data/api/api.dart';
import 'package:next_shop_app/src/data/repository/repository.dart';
import 'package:next_shop_app/src/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/04-categories-screen/cubit/categories_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/05-category-screen/cubit/category_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/07-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/08-orders-screen/cubit/orders_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

void initGetIt() {
  /// BLoC
  getIt.registerFactory(() => HomeScreenCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => CategoryCubit(getIt()));
  getIt.registerFactory(() => CategoriesCubit(getIt()));
  getIt.registerFactory(() => CartCubit());
  getIt.registerFactory(() => OrdersCubit(getIt()));
  getIt.registerFactory(() => UserCubit(getIt()));
  getIt.registerFactory(() => ManageProductsCubit(getIt()));

  /// Repository
  getIt.registerLazySingleton(() => ApiRepository(getIt()));

  /// ApiServices
  getIt.registerLazySingleton(() => ApiServices(getIt()));

  /// Dio
  getIt.registerLazySingleton<BaseDioHelper>(() => DioHelper());

  /// External
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
