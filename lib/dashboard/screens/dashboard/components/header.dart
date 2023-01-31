import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/dashboard/controllers/MenuController.dart';
import 'package:admin/dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
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
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context)) Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        // ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
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
      child: Row(
        children: [
          Container(
            width: 300.w,
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
        ],
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
        // dashboardController.searchData.clear();
        // dashboardController.update();
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
