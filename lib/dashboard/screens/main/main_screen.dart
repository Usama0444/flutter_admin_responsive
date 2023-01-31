import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/View/add_assets.dart';
import 'package:admin/View/add_user.dart';
import 'package:admin/View/create_branch.dart';
import 'package:admin/View/create_category.dart';
import 'package:admin/View/create_city.dart';
import 'package:admin/dashboard/controllers/MenuController.dart';
import 'package:admin/dashboard/responsive.dart';
import 'package:admin/dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var controller = Get.put(MenuController());
  List<Widget> screens = [DashboardScreen(), AddUser(), CreateBrach(), CreateCategory(), CreateCity(), AddAssets()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: GetBuilder<MenuController>(builder: (controller) {
                return screens[controller.currentIndex];
              }),
            ),
          ],
        ),
      ),
    );
  }
}
