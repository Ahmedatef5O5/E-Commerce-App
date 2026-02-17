import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.textInfo,
    this.suffix,
    this.prefix,
  });
  final String label, textInfo;
  final Widget? suffix, prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    suffix ?? const SizedBox(),
                    Gap(16),
                    Text(
                      textInfo,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    prefix ?? const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
