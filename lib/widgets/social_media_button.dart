import 'package:flutter/material.dart';
import '../utilities/app_colors.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key, this.icon, this.label, this.onPressed});

  final String? label;
  final Widget? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(width: .8, color: Colors.blueGrey.shade100),
      ),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          // maximumSize: Size(double.infinity, 35),
          minimumSize: Size(double.infinity, 20),
          elevation: 0,
          overlayColor: Colors.transparent,
        ),
        icon: icon,

        // Gap(12),
        label: Text(
          label ?? '',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
