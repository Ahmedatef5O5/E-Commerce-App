import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/empty_cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widgets/check_out_section.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: BlocProvider.of<CartCubit>(context),
      buildWhen: (previous, current) =>
          current is CartLoaded ||
          current is CartLoading ||
          current is CartFailure,
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: CupertinoActivityIndicator(color: Colors.black12),
          );
        } else if (state is CartLoaded) {
          final cartItems = state.cartItems;
          return (cartItems.isEmpty)
              ? EmptyCartState()
              : Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 260),
                        child: SingleChildScrollView(
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Divider(
                                    color: Colors.grey.shade200,
                                    indent: 15,
                                    endIndent: 15,
                                  ),
                                ),
                                itemBuilder: (context, index) {
                                  return CartItem(
                                    cartItem: state.cartItems[index],
                                  );
                                },
                              ),
                              Gap(35),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: BlocBuilder<CartCubit, CartState>(
                        buildWhen: (previous, current) =>
                            current is SubtotalUpdated,
                        builder: (context, subtotalstate) {
                          if (subtotalstate is SubtotalUpdated) {
                            return CheckOutSection(
                              subtotal: subtotalstate.subtotal,
                            );
                          }
                          return CheckOutSection(subtotal: state.subtotal);
                        },
                      ),
                    ),
                  ],
                );
        } else if (state is CartFailure) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
