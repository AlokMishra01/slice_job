import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../../constants/app_colors.dart';
import '../../blogs/views/blogs_view.dart';
import '../../jobs/views/job_filter_view.dart';
import '../../jobs/views/job_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/nav_bar_controller.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = context.watch<NavBarController>();

    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: navigator.pageController,
          children: const [
            JobView(),
            JobFilterView(),
            BlogsView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: Material(
          color: AppColors.primary,
          child: SafeArea(
            child: SlidingClippedNavBar(
              backgroundColor: AppColors.primary,
              onButtonPressed: navigator.setSelectedIndex,
              activeColor: AppColors.white,
              inactiveColor: AppColors.white.withOpacity(0.6),
              selectedIndex: navigator.selectedIndex,
              iconSize: 24.0,
              barItems: <BarItem>[
                BarItem(
                  icon: Ionicons.home_outline,
                  title: 'Home',
                ),
                BarItem(
                  icon: Ionicons.briefcase_outline,
                  title: 'Jobs',
                ),
                BarItem(
                  icon: Ionicons.chatbox_ellipses_outline,
                  title: 'Blogs',
                ),
                BarItem(
                  icon: Ionicons.person_outline,
                  title: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
