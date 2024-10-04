import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constants.dart';

class MobileAppBar extends SliverPersistentHeaderDelegate {
  final bool isDrawerOpen;
  final VoidCallback onMenuPressed;

  MobileAppBar({required this.isDrawerOpen, required this.onMenuPressed});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AppBar(
      backgroundColor: AppColors.blackAndWhiteColor(context),
      foregroundColor: AppColors.notBlackAndWhiteColor(context),
      elevation: 0.0,
      forceMaterialTransparency: false,
      surfaceTintColor: AppColors.blackAndWhiteColor(context),
      shadowColor: AppColors.notBlackAndWhiteColor(context),
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: isDrawerOpen
              ? const AlwaysStoppedAnimation(1.0)
              : const AlwaysStoppedAnimation(0.0),
        ),
        onPressed: onMenuPressed,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppConstants.mainCompanyLogo,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12.0),
          Text(
            AppConstants.companyShortName,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.notBlackAndWhiteColor(context)),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
