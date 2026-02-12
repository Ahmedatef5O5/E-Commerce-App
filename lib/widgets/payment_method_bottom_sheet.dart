import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../utilities/app_images.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 6,
                color: Colors.grey.shade300,
                indent: 150,
                endIndent: 150,
                radius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                  right: Radius.circular(50),
                ),
              ),
              Gap(15),
              Text(
                'Payment Method',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Gap(8),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                        bloc: paymentMethodsCubit,
                        buildWhen: (previous, current) =>
                            current is PaymentMethodsFetching ||
                            current is PaymentMethodsFetched ||
                            current is PaymentMethodsFetchError,
                        builder: (context, state) {
                          if (state is PaymentMethodsFetching) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.black12,
                                ),
                              ),
                            );
                          } else if (state is PaymentMethodsFetched) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.paymentCards.length,
                              itemBuilder: (context, index) {
                                final card = state.paymentCards[index];
                                return Card(
                                  // color: Colors.amber,
                                  child: ListTile(
                                    minVerticalPadding: 20,
                                    leading: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 8,
                                        ),
                                        child: Image.asset(
                                          card.cardType == CardType.visaCard
                                              ? AppImages.visaCard
                                              : card.cardType ==
                                                    CardType.paypalCard
                                              ? AppImages.paypalCard
                                              : AppImages.masterCard,
                                        ),
                                        // CachedNetworkImage(
                                        //   imageUrl:
                                        //       'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png',
                                        //   placeholder: (context, url) =>
                                        //       CupertinoActivityIndicator(
                                        //         color: Colors.black12,
                                        //       ),
                                        //   errorWidget: (context, url, error) =>
                                        //       Icon(
                                        //         Icons.error,
                                        //         color: Colors.red,
                                        //       ),

                                        //   width: 45,
                                        //   height: 45,
                                        //   fit: BoxFit.contain,
                                        // ),
                                      ),
                                    ),
                                    title: Text(
                                      state.paymentCards[index].maskedNumber,
                                    ),
                                    subtitle: Text(
                                      state.paymentCards[index].cardHolderName,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is PaymentMethodsFetchError) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.18,
                              child: Center(child: Text(state.errMsg)),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      Gap(4),
                      Card(
                        child: ListTile(
                          onTap: () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.addNewCardViewRoute),
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              CupertinoIcons.add_circled,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            'Add Payment Method',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                          ),
                          trailing: Image.asset(
                            AppImages.additionalCards,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Gap(4),
                    ],
                  ),
                ),
              ),
              Gap(8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff514eb7),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
