import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.labelTxtbtn,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.leadingIcon,
    this.width,
    this.height,
    this.style,
  });

  final String? labelTxtbtn;
  final Widget? child;
  final ButtonStyle? style;
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
              backgroundColor:
                  backgroundColor ?? Theme.of(context).primaryColor,
              foregroundColor: foregroundColor ?? AppColors.whiteColor,
            ),
        onPressed: onPressed,
        child:
            child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null) ...[
                  leadingIcon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  labelTxtbtn!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: foregroundColor ?? AppColors.whiteColor,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
