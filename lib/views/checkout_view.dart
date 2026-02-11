import 'package:ecommerce_app/cubit/Checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/checkout_head_line.dart';
import 'package:ecommerce_app/widgets/custom_add_container.dart';
import 'package:ecommerce_app/widgets/price_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCartItems();
        return cubit;
      },

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 24),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Payment',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),

        body: Builder(
          builder: (context) {
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: BlocProvider.of<CheckoutCubit>(context),
              buildWhen: (previous, current) =>
                  current is CheckoutLoading ||
                  current is CheckoutLoaded ||
                  current is CheckoutFailure,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Center(
                      child: CupertinoActivityIndicator(color: Colors.black12),
                    ),
                  );
                } else if (state is CheckoutLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          CheckoutHeadline(title: 'Address', onTap: () {}),
                          Gap(10),
                          CustomAddContainer(title: 'Add Shiping address'),
                          Gap(10),
                          CheckoutHeadline(
                            title: 'Products',
                            onTap: null,
                            numOfProducts: state.numOfProducts,
                          ),
                          Gap(10),
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
                              return CartItem(cartItem: state.cartItems[index]);
                            },
                          ),
                          Gap(10),

                          CheckoutHeadline(
                            title: 'Payment Methods',
                            onTap: null,
                          ),
                          Gap(10),
                          CustomAddContainer(title: 'Add Payment method'),
                          Gap(25),
                          PriceRow(
                            label: 'Total Amount',
                            value: state.totalAmount,
                          ),
                          Gap(25),
                          ElevatedButton(
                            onPressed: () {},
                            // onPressed: () => Navigator.of(
                            //   context,
                            //   rootNavigator: true,
                            // ).pushNamed(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff514eb7),
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Proceed to Buy',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Gap(50),
                        ],
                      ),
                    ),
                  );
                } else if (state is CheckoutFailure) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Center(child: Text(state.errMsg)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
