import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/empty_cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back, size: 28),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        title: Text('My Cart', style: TextStyle(fontSize: 20)),
        centerTitle: true,

        actions: [Icon(Icons.shopping_bag_outlined, size: 26)],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: BlocProvider.of<CartCubit>(context),
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CupertinoActivityIndicator(color: Colors.black12),
            );
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;
            return (cartItems.isEmpty)
                ? EmptyCartState()
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // to avoid doble scrolling
                          itemCount: state.cartItems.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Divider(
                              color: Colors.grey.shade200,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return CartItem(
                              cartProduct: state.cartItems[index],
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Divider(
                            color: Colors.grey.shade200,
                            indent: 15,
                            endIndent: 15,
                          ),
                        ),
                      ],
                    ),
                  );
          } else if (state is CartFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
