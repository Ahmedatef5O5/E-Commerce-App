import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/utilities/custom_formatter.dart';
import 'package:ecommerce_app/widgets/label_with_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../utilities/app_colors.dart';

class AddNewCardView extends StatefulWidget {
  const AddNewCardView({super.key});

  @override
  State<AddNewCardView> createState() => _AddNewCardViewState();
}

class _AddNewCardViewState extends State<AddNewCardView> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _expirtyDateController = TextEditingController();
  final TextEditingController _cvvCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
            'Add New Card',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelWithTextField(
                            labelTxt: 'Card Number',
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Image.asset(
                                AppImages.cardNumber,
                                width: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            hintTxt: 'Enter Card Number',
                          ),
                          Gap(15),
                          LabelWithTextField(
                            labelTxt: 'Card Holder Name',
                            controller: _holderNameController,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]'),
                              ),
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                AppImages.holderCardName,
                                width: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            hintTxt: 'Enter Card holder name',
                          ),
                          Gap(15),
                          LabelWithTextField(
                            labelTxt: 'Expiry Date',
                            controller: _expirtyDateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4), // MM YY
                              CardMonthInputFormatter(), // add slash after first two digits ..
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(9.5),
                              child: Image.asset(
                                AppImages.expirtyDate,
                                width: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            hintTxt: 'MM/YY',
                          ),
                          Gap(15),
                          LabelWithTextField(
                            labelTxt: 'CVV',
                            controller: _cvvCodeController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                AppImages.cvvCode,
                                width: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            hintTxt: 'Enter cvv',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                    listener: (context, state) {
                      if (state is AddNewCardSuccessLoaded) {
                        Navigator.of(context).pop(true);
                      } else if (state is AddNewCardFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.errMsg)));
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AddNewCardLoading ||
                        current is AddNewCardSuccessLoaded ||
                        current is AddNewCardFailure,
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is AddNewCardLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyWithShade,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: CupertinoActivityIndicator(
                            color: Colors.black12,
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final typeOfCard = cubit.getCardTypeFromNumber(
                              _cardNumberController.text,
                            );
                            cubit.addNewCard(
                              _cardNumberController.text,
                              _holderNameController.text,
                              _expirtyDateController.text.replaceAll(
                                '/',
                                '',
                              ), // remove splash before store Expirty date
                              _cvvCodeController.text,
                              typeOfCard,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff514eb7),
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Add Card',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    },
                  ),
                  Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
