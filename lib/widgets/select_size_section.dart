import 'package:ecommerce_app/cubit/Product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(3),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          bloc: BlocProvider.of<ProductDetailsCubit>(context),
          buildWhen: (previous, current) => current is SelectedSizeState,
          builder: (context, state) {
            return Row(
              children: ProductSize.values
                  .map(
                    (size) => Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: InkWell(
                        onTap: () => BlocProvider.of<ProductDetailsCubit>(
                          context,
                        ).selectSize(size),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                state is SelectedSizeState && state.size == size
                                ? Theme.of(context).primaryColor
                                : AppColors.greyWithShade,
                          ),
                          child: Center(
                            child: Text(
                              size.name,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color:
                                        state is SelectedSizeState &&
                                            state.size == size
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
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
            );
          },
        ),
      ],
    );
  }
}
