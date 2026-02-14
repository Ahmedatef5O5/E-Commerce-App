import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.label,
    this.value,
    this.isLoading = false,
  });
  final String label;
  final double? value;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        isLoading
            ? Center(child: CupertinoActivityIndicator(color: Colors.black12))
            : Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.bottom,
                      child: Transform.translate(
                        offset: const Offset(-1, -7),
                        child: Text(
                          '\$',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: value?.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
