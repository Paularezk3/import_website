import 'package:flutter/material.dart';
import 'package:import_website/core/utils/app_constants.dart';
import 'package:import_website/modules/home/views/mobile_home_content.dart';
import '../../../core/utils/app_colors.dart';
import '../../../widgets/responsive_widget.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: MobileHomeContent(),
      tablet: TabletHomeContent(),
      desktop: DesktopHomeContent(),
    );
  }
}

class TabletHomeContent extends StatelessWidget {
  const TabletHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4.0,
        title: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50, // Adjust the size as needed
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment(-0.71, -1),
                      end: Alignment(0.71, 0.71),
                      colors: [Colors.transparent],
                    ),
                    border: Border.all(
                      width: 0,
                    ),
                    boxShadow: AppColors.iconsShadows(context),
                  ),
                ),
                Image.asset(
                  AppConstants.mainCompanyLogo,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                AppConstants.companyShortName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Home
            },
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to Services
            },
            child:
                const Text('Services', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to About
            },
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to Contact
            },
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              // Sign in action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
            child: const Text('Sign In'),
          ),
        ],
      ),
      body: const Center(
        child: Text('Tablet Home Content'),
      ),
    );
  }
}

class DesktopHomeContent extends StatelessWidget {
  const DesktopHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4.0,
        title: Row(
          children: [
            Image.asset(
              AppConstants.mainCompanyLogo,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 20),
            const Text(AppConstants
                .companyShortName), // Display company name for desktop
            const Spacer(),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to Home
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Services
                  },
                  child: const Text(
                    'Services',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to About
                  },
                  child: const Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Contact
                  },
                  child: const Text(
                    'Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Sign in action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Desktop Home Content'),
      ),
    );
  }
}
