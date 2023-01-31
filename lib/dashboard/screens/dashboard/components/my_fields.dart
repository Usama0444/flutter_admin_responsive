import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/dashboard/models/MyFiles.dart';
import 'package:admin/dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "My Record",
        //       style: Theme.of(context).textTheme.subtitle1,
        //     ),
        //     Row(
        //       children: [
        //         ElevatedButton.icon(
        //           style: TextButton.styleFrom(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: defaultPadding * 1.5,
        //               vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //             ),
        //           ),
        //           onPressed: () {
        //             AdaptiveTheme.of(context).toggleThemeMode();
        //           },
        //           icon: Icon(Icons.ac_unit_sharp),
        //           label: Text("Change Theme"),
        //         ),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         ElevatedButton.icon(
        //           style: TextButton.styleFrom(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: defaultPadding * 1.5,
        //               vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        //             ),
        //           ),
        //           onPressed: () {},
        //           icon: Icon(Icons.add),
        //           label: Text("Add New"),
        //         ),
        //       ],
        //     ),

        //   ],
        // ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  DashboardController controller = Get.put(DashboardController());

  var lst = [
    'Branch',
    'Category',
    'City',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.dataCounts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      List<int> countsList = [
        controller.branchCount,
        controller.categoryCount,
        controller.cityCount,
      ];
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemBuilder: (context, index) => FileInfoCard(
          info: CloudStorageInfo(
            title: lst[index],
            numOfFiles: countsList[index],
            svgSrc: "assets/icons/Documents.svg",
            totalStorage: "1.9GB",
            color: index == 0
                ? primaryColor
                : index == 1
                    ? Color(0xFF26E5FF)
                    : Color(0xFFFFCF26),
            percentage: 35,
          ),
        ),
      );
    });
  }
}
