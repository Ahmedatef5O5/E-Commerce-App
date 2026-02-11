import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/widgets/label_with_text_field_new_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelWithTextFieldNewCard(
                labelTxt: 'Card Number',
                controller: _cardNumberController,
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
              LabelWithTextFieldNewCard(
                labelTxt: 'Card Holder Name',
                controller: _holderNameController,
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
              LabelWithTextFieldNewCard(
                labelTxt: 'Expiry Date',
                controller: _expirtyDateController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(9.5),
                  child: Image.asset(
                    AppImages.expirtyDate,
                    width: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                hintTxt: 'Enter expiry date',
              ),
              Gap(15),
              LabelWithTextFieldNewCard(
                labelTxt: 'CVV',
                controller: _cvvCodeController,
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
              Spacer(),
              ElevatedButton(
                onPressed: () {},
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
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
