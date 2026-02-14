import 'package:ecommerce_app/utilities/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../Router/app_routes.dart';
import '../cubit/Checkout_cubit/checkout_cubit.dart';
import '../models/location_item_model.dart';

class SelectedLocationWidget extends StatelessWidget {
  const SelectedLocationWidget({super.key, required this.selectedLocation});

  final LocationItemModel? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final newLocation = await Navigator.of(
          context,
        ).pushNamed(AppRoutes.locationViewRoute);
        if (newLocation != null && newLocation is LocationItemModel) {
          if (context.mounted) {
            context.read<CheckoutCubit>().setLocation(newLocation);
          }
        }
      },

      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(color: Colors.blueGrey.shade100, width: 1.2),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 3),
              child: Image.asset(
                AppImages.currLocation,
                width: 95,
                height: 115,
              ),
            ),

            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(14),
                  Text(
                    selectedLocation!.city,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(2),
                  Text(
                    '${selectedLocation!.city}, ${selectedLocation!.country} ',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(2),
                  Text(
                    'Apt 12, 4th Floor, Bldg 45, Road 9, Maadi.',
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
