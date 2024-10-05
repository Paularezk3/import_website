import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_website/core/utils/app_colors.dart';
import 'package:import_website/core/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../routes/pages_names.dart';

class ClickableLogo extends StatefulWidget {
  @override
  _ClickableLogoState createState() => _ClickableLogoState();
}

class _ClickableLogoState extends State<ClickableLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle click event here, for example, navigate to another page
        Get.toNamed(PagesNames.home);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to hand when hovering
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: _isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(), // Scale up on hover
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey.withOpacity(0) : Colors.transparent, // Background change on hover
            borderRadius: BorderRadius.circular(8), // Slightly rounded corners
          ),
          padding: const EdgeInsets.all(8.0), // Add some padding around the row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppConstants.mainCompanyLogo,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12.0),
              if (MediaQuery.of(context).size.width > 700)
                Text(
                  AppConstants.companyShortName.tr,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.notBlackAndWhiteColor(context),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
