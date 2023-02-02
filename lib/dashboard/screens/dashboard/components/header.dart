import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/dashboard/controllers/MenuController.dart';
import 'package:admin/dashboard/responsive.dart';
import 'package:admin/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  bool isAssetPage = false;
  Header({
    Key? key,
    required this.isAssetPage,
  }) : super(key: key);
  var controller = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: controller.controlMenu,
          ),
        if (!Responsive.isMobile(context))
          isAssetPage
              ? Text(
                  "",
                  style: Theme.of(context).textTheme.headline6,
                )
              : Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.headline6,
                ),
        if (!Responsive.isMobile(context)) Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  var controller = Get.put(DashboardController());

  ProfileCard({
    Key? key,
  }) : super(key: key);
  var dropVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Container(
        width: 300.w,
        height: 70.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: DropdownButtonFormField<String>(
              value: dropVal,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              hint: Text(
                'Search by',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.grey[600],
                ),
              ),
              onChanged: (value) {
                dropVal = value!;
                if (dropVal == 'City') {
                  controller.isCitySearch = true;
                  controller.isBranchSearch = false;
                  controller.isCategorySearch = false;
                  controller.update();
                } else if (dropVal == 'Branch') {
                  controller.isCitySearch = false;
                  controller.isBranchSearch = true;
                  controller.isCategorySearch = false;
                  controller.update();
                } else {
                  controller.isCitySearch = F;
                  controller.isBranchSearch = false;
                  controller.isCategorySearch = true;
                  controller.update();
                }
              },
              validator: (value) => value == null ? 'Selection required' : null,
              items: ['City', 'Room', 'Floor', 'Date', 'Branch', 'Category', 'Holder Name'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);
  var dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dashboardController.searchInputTypeData,
      onChanged: ((value) {
        if (value.isEmpty) {
          dashboardController.dataCounts();
        } else
          dashboardController.searchAssetsRecord();
      }),
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            dashboardController.searchAssetsRecord();
          },
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
