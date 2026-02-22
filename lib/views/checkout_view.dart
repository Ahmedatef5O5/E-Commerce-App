import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/cubit/Checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/checkout_head_line.dart';
import 'package:ecommerce_app/widgets/custom_add_container.dart';
import 'package:ecommerce_app/widgets/custom_elevated_button.dart';
import 'package:ecommerce_app/widgets/payment_method_item.dart';
import 'package:ecommerce_app/widgets/price_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../utilities/app_colors.dart';
import '../widgets/selected_location_widget.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.getCartItems();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = PaymentMethodsCubit();
            cubit.fetchPaymentMethods();
            return cubit;
          },
        ),
      ],
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
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 19,
              color: AppColors.blackColor,
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
                  final chosenPaymentCard = state.chosenPaymentCard;
                  final selectedLocation = context
                      .watch<CheckoutCubit>()
                      .selectedLocation;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CheckoutHeadline(
                                    title: 'Address',
                                    onTap: () async {
                                      final newLocation = await Navigator.of(
                                        context,
                                      ).pushNamed(AppRoutes.locationViewRoute);
                                      if (newLocation != null &&
                                          newLocation is LocationItemModel) {
                                        if (context.mounted) {
                                          context
                                              .read<CheckoutCubit>()
                                              .setLocation(newLocation);
                                        }
                                      }
                                    },
                                  ),
                                  Gap(10),
                                  selectedLocation != null
                                      ? SelectedLocationWidget(
                                          selectedLocation: selectedLocation,
                                        )
                                      : CustomAddContainer(
                                          title: 'Add Shiping address',
                                          onTap: () async {
                                            // Navigator.of(context).pushNamed(
                                            //     AppRoutes.locationViewRoute,

                                            //   );
                                            final newLocation =
                                                await Navigator.of(
                                                  context,
                                                ).pushNamed(
                                                  AppRoutes.locationViewRoute,
                                                );
                                            if (newLocation != null &&
                                                newLocation
                                                    is LocationItemModel) {
                                              if (context.mounted) {
                                                context
                                                    .read<CheckoutCubit>()
                                                    .setLocation(newLocation);
                                              }
                                            }
                                          },
                                        ),
                                  Gap(10),
                                  CheckoutHeadline(
                                    title: 'Products',
                                    onTap: null,
                                    numOfProducts: state.numOfProducts,
                                  ),
                                  Gap(10),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    // to avoid doble scrolling
                                    itemCount: state.cartItems.length,
                                    separatorBuilder: (context, index) =>
                                        Padding(
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
                                  Gap(10),

                                  CheckoutHeadline(
                                    title: 'Payment Methods',
                                    onTap: null,
                                  ),
                                  Gap(10),

                                  state.chosenPaymentCard == null
                                      ? CustomAddContainer(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                AppRoutes.addNewCardViewRoute,
                                              )
                                              .then(((_) {
                                                // BlocProvider.of<CheckoutCubit>(context).getCartItems(); another sol (not safe)
                                                if (context.mounted) {
                                                  context
                                                      .read<CheckoutCubit>()
                                                      .getCartItems();
                                                }
                                              })),
                                          title: 'Add Payment method',
                                        )
                                      : PaymentMethodItem(
                                          paymentCardModel:
                                              state.chosenPaymentCard,
                                        ),
                                  Gap(25),
                                  Divider(color: Colors.grey.shade300),
                                  Gap(45),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            buildWhen: (previous, current) =>
                                current is CartLoaded ||
                                current is SubtotalUpdated ||
                                current is CartLoading,
                            builder: (context, state) {
                              // if (state is CartLoading) {
                              //   return Center(
                              //     child: CupertinoActivityIndicator(
                              //       color: Colors.black12,
                              //     ),
                              //   );
                              // }

                              //  else {
                              final subtotal = state is CartLoaded
                                  ? state.subtotal
                                  : (state is SubtotalUpdated)
                                  ? state.subtotal
                                  : 0;
                              final totalPrice = subtotal + 6.0;
                              return Column(
                                children: [
                                  Gap(5),
                                  PriceRow(
                                    label: 'Total Amount',
                                    value: totalPrice,
                                    isLoading: state is CartLoading,
                                  ),
                                  Gap(20),
                                  CustomElevatedButton(
                                    width: double.infinity,
                                    height: 55,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    onPressed: state is CartLoading
                                        ? null
                                        : () {},
                                    child: const Text(
                                      'Proceed to Buy',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Gap(20),
                                ],
                              );
                              // }
                            },
                          ),
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
