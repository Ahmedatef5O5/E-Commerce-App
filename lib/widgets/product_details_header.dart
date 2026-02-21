import 'package:ecommerce_app/widgets/custome_product_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/Product_details_cubit/product_details_cubit.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({
    super.key,
    required this.productName,
    required this.productId,
  });

  final String productName;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              bloc: BlocProvider.of<ProductDetailsCubit>(context),
              buildWhen: (previos, current) =>
                  current is QuantityCounterLoaded ||
                  current is ProductDetailsSuccessLoaded,
              builder: (context, state) {
                if (state is QuantityCounterLoaded) {
                  return CustomProductCounter(
                    quantity: state.value,
                    onIncrement: () => cubit.incrementQuantity(productId),
                    onDecrement: () => cubit.decrementQuantity(productId),
                  );
                } else if (state is ProductDetailsSuccessLoaded) {
                  return CustomProductCounter(
                    quantity: state.quantity,
                    onIncrement: () =>
                        cubit.incrementQuantity(state.product.id),
                    onDecrement: () =>
                        cubit.decrementQuantity(state.product.id),
                  );
                } else {
                  // return const CustomProductCounter(quantity: 0);
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
