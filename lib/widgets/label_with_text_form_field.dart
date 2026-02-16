import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class LabelWithTextField extends StatefulWidget {
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
    this.isPassword = false,
  });
  final String labelTxt, hintTxt;
  final TextStyle? labelStyle, hintStyle, inputStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;

  @override
  State<LabelWithTextField> createState() => _LabelWithTextFieldState();
}

class _LabelWithTextFieldState extends State<LabelWithTextField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12),
        Text(
          widget.labelTxt,
          style:
              widget.labelStyle ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: AppColors.blackColor,
              ),
        ),
        Gap(12),
        TextFormField(
          obscureText: widget.isPassword ? _obscureText : false,
          style: widget.inputStyle,
          controller: widget.controller,
          validator: (value) => value == null || value.isEmpty
              ? '${widget.labelTxt} Required'
              : null,
          cursorColor: AppColors.blueGreyWithShade3,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: AppColors.blueGreyWithShade3,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null,
            suffixIconColor: AppColors.blueGreyWithShade3,
            hintText: widget.hintTxt,
            hintStyle:
                widget.hintStyle ??
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
