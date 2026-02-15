import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class LabelWithTextField extends StatelessWidget {
  const LabelWithTextField({
    super.key,
    required this.labelTxt,
    required this.hintTxt,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.labelStyle,
    this.hintStyle,
    this.inputStyle,
    this.suffixIcon,
    this.obscureText = false,
  });
  final String labelTxt, hintTxt;
  final TextStyle? labelStyle, hintStyle, inputStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12),
        Text(
          labelTxt,
          style:
              labelStyle ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
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
          cursorColor: AppColors.blueGreyWithShade3,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            prefixIcon: prefixIcon,
            prefixIconColor: AppColors.blueGreyWithShade3,
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.blueGreyWithShade3,
            hintText: hintTxt,
            hintStyle:
                hintStyle ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Colors.grey,
                ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(width: 0.1, color: Colors.grey.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                width: 0.1,
                color: Colors.blueGrey.shade100,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.blueGrey.shade100,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
