import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utilities/app_colors.dart';

class SelectSizeSection extends StatelessWidget {
  const SelectSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(3),
        Row(
          children: ProductSize.values
              .map(
                (size) => Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greyWithShade,
                      ),
                      child: Center(
                        child: Text(
                          size.name,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
