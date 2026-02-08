import 'package:ecommerce_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      expand: false,
      shouldCloseOnMinExtent: false,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: ListView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(50),
              children: [
                Column(
                  children: [
                    Text('Test'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                    Text('data'),
                    Gap(70),
                  ],
                ),
              ],

              // children: [
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              //   Text('data'),
              //   Gap(70),
              // ],
            ),
          ),
    );
  }
}
