import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/presentation/screens/07-orders-screen/cubit/orders_cubit.dart';
import 'package:next_shop_app/presentation/screens/07-orders-screen/empty_orders_display.dart';
import 'package:next_shop_app/presentation/screens/07-orders-screen/order_container.dart';
import 'package:next_shop_app/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class OrdersScreen extends StatefulWidget {
  final Widget drawer;
  const OrdersScreen({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersCubit>(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      body: Column(
        children: [
          const DefaultAppBar(
            pageTitle: 'Orders',
            isShortBar: true,
            showDrawer: false,
          ),
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return LoadingSpinningCircle(
                      color: Theme.of(context).primaryColor);
                }
                if (state is OrdersLoaded) {
                  return ListView.builder(
                    itemCount: state.orders.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = state.orders[index];
                      final prods = context.read<OrdersCubit>().getproducts(
                            prods: order.orderProducts,
                            products: state.allProducts,
                          );
                      return OrderContainer(order: order, prods: prods);
                    },
                  );
                }
                return const EmptyOrdersDisplay();
              },
            ),
          ),
        ],
      ),
    );
  }
}
