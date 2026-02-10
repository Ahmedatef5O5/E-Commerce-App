import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:ecommerce_app/models/product_details_args_model.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridViewSliver extends StatelessWidget {
  const ProductGridViewSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: CupertinoActivityIndicator(color: Colors.black12),
              ),
            ),
          );
        } else if (state is HomeSuccessLoaded) {
          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Arrivals🔥',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      Text(
                        'See All',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.74,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.productItems.length,
                    (BuildContext context, int index) => InkWell(
                      onTap: () =>
                          Navigator.of(
                            context,
                            rootNavigator:
                                true, // Useful for pushing contents above all subsequent instances of [Navigator].
                          ).pushNamed(
                            AppRoutes.productDetailsRoute,
                            arguments: ProductDetailsArgsModel(
                              id: state.productItems[index].id,
                            ),
                          ),
                      child: ProductItem(
                        productItem: state.productItems[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeFailureLoaded) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text(state.message)),
          );
        } else {
          return SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
