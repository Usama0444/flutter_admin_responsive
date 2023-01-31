import 'package:admin/View/add_user.dart';
import 'package:admin/View/login.dart';
import 'package:admin/dashboard/controllers/MenuController.dart';
import 'package:admin/dashboard/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);
  var controller = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              controller.currentIndex = 0;
              controller.update();
            },
            child: DrawerHeader(
              child: Container(
                  height: 260.h,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/hala.jpg",
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          DrawerListTile(
            title: "Create User",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              controller.currentIndex = 1;
              controller.update();
            },
          ),
          DrawerListTile(
            title: "Create Branch",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              controller.currentIndex = 2;
              controller.update();
            },
          ),
          DrawerListTile(
            title: "Create Category",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              controller.currentIndex = 3;
              controller.update();
            },
          ),
          DrawerListTile(
            title: "Create City",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              controller.currentIndex = 4;
              controller.update();
            },
          ),
          DrawerListTile(
            title: "Go to the Asset page",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              controller.currentIndex = 5;
              controller.update();
            },
          ),
          DrawerListTile(
            title: "LogOut",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              Get.offAll(Login());
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
