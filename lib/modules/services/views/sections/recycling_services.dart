import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_colors.dart';

class RecyclingServices extends StatelessWidget {
  final bool isMobile;
  const RecyclingServices({required this.isMobile, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
          Text(
            "Recycling Services Overview",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.notBlackAndWhiteColor(context)),
          ),
          SizedBox(
            height: isMobile ? 15 : 20,
          ),
          Text(
            "Al Masria imports diverse recycling machines, ensuring quality and reliability for our clients.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: isMobile ? 30 : 40,
          ),
        ],
      ),
    );
  }
}
