import 'package:flutter/material.dart';
import 'package:import_website/widgets/defaults/clickable_logo.dart';
import '../../core/utils/app_colors.dart';

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
      title: ClickableLogo(),
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
