import 'package:ecommerce_app/cubit/Payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:ecommerce_app/widgets/payment_method_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({super.key, this.paymentCardModel});
  final PaymentCardModel? paymentCardModel;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey.shade100, width: 1.2),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: () {
          final cubit = context.read<PaymentMethodsCubit>();
          showModalBottomSheet(
            context: context,
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: PaymentMethodBottomSheet(),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.grey.shade300,
          child: Image.asset(
            AppImages.masterCard,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Master Card',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          paymentCardModel?.maskedNumber ?? '**** **** **** ****',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: Colors.black38),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black26,
        ),
      ),
    );
  }
}
