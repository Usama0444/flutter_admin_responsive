import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/Model/assets_model.dart';
import 'package:admin/dashboard/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  var controller = Get.put(DashboardController());
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller.assetsRecord().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: GetBuilder<DashboardController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Record",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                !isLoading
                    ? SizedBox(
                        width: double.infinity,
                        child: DataTable2(
                          columnSpacing: defaultPadding,
                          minWidth: 600,
                          columns: [
                            DataColumn(
                              label: Text("Holder Name"),
                            ),
                            DataColumn(
                              label: Text("Category"),
                            ),
                            DataColumn(
                              label: Text("Branch"),
                            ),
                            DataColumn(
                              label: Text("Floor"),
                            ),
                            DataColumn(
                              label: Text("City"),
                            ),
                            DataColumn(
                              label: Text("Barcode"),
                            ),
                            DataColumn(
                              label: Text("Room"),
                            ),
                          ],
                          rows: List.generate(
                            controller.searchData.length == 0 ? controller.assetsModel.length : controller.searchData.length,
                            (index) => recentFileDataRow(
                              controller.searchData.length == 0 ? controller.assetsModel[index] : controller.searchData[index],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      )
              ],
            );
          },
        ));
  }
}

DataRow recentFileDataRow(AssetsModel assetsModel) {
  return DataRow(
    cells: [
      DataCell(Text(
        assetsModel.holdername!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.category!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.branch!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.floor!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.city!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.assetBarcode!,
        style: TextStyle(fontSize: 16.sp),
      )),
      DataCell(Text(
        assetsModel.room!,
        style: TextStyle(fontSize: 16.sp),
      )),
    ],
  );
}
