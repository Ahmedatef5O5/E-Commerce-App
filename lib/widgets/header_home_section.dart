import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utilities/app_images.dart';

class HeaderHomeSection extends StatelessWidget {
  const HeaderHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(AppImages.tempProfile),
            // backgroundImage: CachedNetworkImageProvider(AppImages.tempProfile), for imageProvider from network
          ),
          Gap(8),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi,Ahmed',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(fontSize: 16),
                  ),
                  Text(
                    'Let\'s go shopping',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                      // color: Theme.of(context).secondaryHeaderColor,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(AppImages.glassSearch, width: 37, height: 37),
              Gap(14),
              Image.asset(
                AppImages.notification2,
                width: 30,
                height: 30,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
