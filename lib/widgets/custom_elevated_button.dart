import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,

    required this.child,
    this.labelTxtbtn,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.leadingIcon,
    this.width,
    this.height,
    this.style,
    this.shape,
  });

  final Widget? labelTxtbtn;
  final Widget child;
  final ButtonStyle? style;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? leadingIcon;
  final double? width, height;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height * 0.065,
      child: ElevatedButton(
        style:
            style ??
            ElevatedButton.styleFrom(
              shape: shape,
              backgroundColor:
                  backgroundColor ?? Theme.of(context).primaryColor,
              foregroundColor: foregroundColor ?? AppColors.whiteColor,
            ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
