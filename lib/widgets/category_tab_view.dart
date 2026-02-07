import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(15),
        Expanded(
          child: ListView.builder(
            itemCount: dummyCategories.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 190,
                  height: 160,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        spreadRadius: 0.1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    dummyCategories[index].imgPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Gap(20),
      ],
    );
  }
}
