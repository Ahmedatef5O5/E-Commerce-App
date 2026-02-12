import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class LabelWithTextFieldNewCard extends StatelessWidget {
  const LabelWithTextFieldNewCard({
    super.key,
    required this.labelTxt,
    required this.hintTxt,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });
  final String labelTxt, hintTxt;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12),
        Text(
          labelTxt,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: AppColors.blackColor,
          ),
        ),
        Gap(12),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value == null || value.isEmpty ? '$labelTxt Required' : null,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            prefixIcon: prefixIcon,
            hintText: hintTxt,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
