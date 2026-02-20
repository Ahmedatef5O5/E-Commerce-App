import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/cubit/Main_Category_cubit/main_category_cubit.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final categoryCubit = MainCategoryCubit()..getCategories();
        // categoryCubit.getCategories();
        return categoryCubit;
      },
      child: BlocBuilder<MainCategoryCubit, MainCategoryState>(
        buildWhen: (previous, current) =>
            current is MainCategoryLoading ||
            current is MainCategoryFailure ||
            current is MainCategorySuccessLoaded,
        builder: (context, state) {
          if (state is MainCategoryLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: Center(
                child: CupertinoActivityIndicator(color: Colors.black12),
              ),
            );
          } else if (state is MainCategorySuccessLoaded) {
            return Column(
              children: [
                Gap(15),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.categories.length,

                    // itemCount: dummyCategories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                          left: 14,
                          right: 14,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(22),
                            child: Container(
                              width: 190,
                              height: 160,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 2,
                                    spreadRadius: 0.1,
                                    offset: const Offset(-2, -2),
                                  ),
                                ],
                              ),
                              child: CachedNetworkImage(
                                imageUrl: category.imgPath.trim(),
                                // dummyCategories[index].imgPath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                // child: Image.asset(
                                //   dummyCategories[index].imgPath,
                                //   fit: BoxFit.contain,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Gap(20),
              ],
            );
          } else if (state is MainCategoryFailure) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
              child: Center(child: Text(state.errMsg)),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
