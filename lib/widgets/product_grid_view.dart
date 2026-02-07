import 'package:ecommerce_app/Router/app_routes.dart';
import 'package:ecommerce_app/cubit/Home_cubit/home_cubit.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: CupertinoActivityIndicator(color: Colors.black12),
            ),
          );
        } else if (state is HomeSuccessLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrivals🔥',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.productItems.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () =>
                        Navigator.of(
                          context,
                          rootNavigator:
                              true, // Useful for pushing contents above all subsequent instances of [Navigator].
                        ).pushNamed(
                          AppRoutes.productDetailsRoute,
                          arguments: {
                            'id': state.productItems[index].id,
                            'product': state.productItems[index],
                          },
                        ),
                    child: ProductItem(productItem: state.productItems[index]),
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeFailureLoaded) {
          return Center(child: Text(state.message));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
