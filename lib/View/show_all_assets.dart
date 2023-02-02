import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;
import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/dashboard/constants.dart';
import 'package:admin/dashboard/screens/dashboard/components/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_assets.dart';
import 'package:admin/Model/assets_model.dart';
import 'package:admin/Model/assets_model.dart';
import 'package:admin/View/add_assets.dart';
import 'package:admin/utils/reusabale.dart';
import 'package:admin/utils/toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ShowAllAssets extends StatefulWidget {
  ShowAllAssets();

  @override
  State<ShowAllAssets> createState() => _ShowAllAssetsState();
}

class _ShowAllAssetsState extends State<ShowAllAssets> {
  AddAssetsController assetss = Get.find<AddAssetsController>();
  var dashbobardController = Get.put(DashboardController());
  List<AssetsModel> assets = [];
  List<List<String>> exportAndShare = [];

  //___________________________UPDATE LIST
  updateList() {
    exportAndShare.add([
      'CITY',
      'CATEGORY',
      'BRANCH',
      'FLOOR',
      'ROOM',
      'REF',
      'SUBCATEGORY',
      'ERPREF',
      'HOLDERNAME',
      'SER NO',
      'ASS DES',
      'ASSET BARCODE',
    ]);
    if (dashbobardController.searchData.isEmpty) {
      for (int i = 0; i < assets.length; i++) {
        exportAndShare.add([
          assets[i].city.toString(),
          assets[i].category.toString(),
          assets[i].branch.toString(),
          assets[i].floor.toString(),
          assets[i].room.toString(),
          assets[i].ref.toString(),
          assets[i].subCategory.toString(),
          assets[i].erpRef.toString(),
          assets[i].holdername.toString(),
          assets[i].serNo.toString(),
          assets[i].assetsDes.toString(),
          assets[i].assetBarcode.toString(),
        ]);
      }
    } else {
      for (int i = 0; i < dashbobardController.searchData.length; i++) {
        exportAndShare.add([
          dashbobardController.searchData[i].city.toString(),
          dashbobardController.searchData[i].category.toString(),
          dashbobardController.searchData[i].branch.toString(),
          dashbobardController.searchData[i].floor.toString(),
          dashbobardController.searchData[i].room.toString(),
          dashbobardController.searchData[i].ref.toString(),
          dashbobardController.searchData[i].subCategory.toString(),
          dashbobardController.searchData[i].erpRef.toString(),
          dashbobardController.searchData[i].holdername.toString(),
          dashbobardController.searchData[i].serNo.toString(),
          dashbobardController.searchData[i].assetsDes.toString(),
          dashbobardController.searchData[i].assetBarcode.toString(),
        ]);
      }
    }
    //commit
  }

  //________________________SAVE EXCEL SHEET
  saveList() async {
    String csvData = ListToCsvConverter().convert(exportAndShare);
    final String directory = (await getApplicationSupportDirectory()).path;
    print(directory);
    final path = "$directory/csv-${DateTime.now()}.csv";
    print('File Saved in Given Path=$path');
    toast('File Saved at Path=$path');
    final File file = File(path);
    await file.writeAsString(csvData);
    shareFile(file);
  }

  //____________________________SHARE FILE
  shareFile(File file) {
    Share.shareFiles([file.path]);
  }

  void generateCSV() {
//now convert our 2d array into the csvlist using the plugin of csv
    String csv = const ListToCsvConverter().convert(exportAndShare);
//this csv variable holds entire csv data
//Now Convert or encode this csv string into utf8
    final bytes = utf8.encode(csv);
//NOTE THAT HERE WE USED HTML PACKAGE
    final blob = html.Blob([bytes]);
//It will create downloadable object
    final url = html.Url.createObjectUrlFromBlob(blob);
//It will create anchor to download the file
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${DateTime.now()}.csv';
//finally add the csv anchor to body
    html.document.body?.children.add(anchor);
// Cause download by calling this function
    anchor.click();
//revoke the object
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          title: Header(isAssetPage: true),
        ),
        floatingActionButton: GestureDetector(
          onTap: () async {
            await updateList();
            // await saveList();
            generateCSV();
          },
          child: MyButton(
            btnWidth: 100.w,
            btnHeight: 60.h,
            btnColor: Colors.grey[500],
            btnTxt: 'Excel Import',
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: assetss.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                );
              } else {
                var docs = snapshot.data?.docs;

                var ids = [];
                assets.clear();
                for (int i = 0; i < docs!.length; i++) {
                  assets.add(AssetsModel(
                    city: docs[i]['city'],
                    assetBarcode: docs[i]['assetsBarcode'],
                    assetsDes: docs[i]['assetsDes'],
                    assetsImg: docs[i]['assetsImage'],
                    branch: docs[i]['branch'],
                    category: docs[i]['category'],
                    erpRef: docs[i]['repRef'],
                    floor: docs[i]['floor'],
                    holdername: docs[i]['holderName'],
                    ref: docs[i]['ref'],
                    room: docs[i]['room'],
                    serNo: docs[i]['serNo'],
                    subCategory: docs[i]['subCategory'],
                    date: docs[i]['date'],
                  ));
                  ids.add(docs[i]['id']);
                }
                return GetBuilder<DashboardController>(builder: (dashboardController) {
                  return SizedBox(
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
                        DataColumn(
                          label: Text("Date"),
                        ),
                      ],
                      rows: List.generate(
                        dashbobardController.searchData.length == 0 ? dashbobardController.assetsModel.length : dashbobardController.searchData.length,
                        (index) => recentFileDataRow(
                          dashbobardController.searchData.length == 0 ? dashbobardController.assetsModel[index] : dashbobardController.searchData[index],
                        ),
                      ),
                    ),
                  );
                });
              }
            }),
      ),
    );
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
        DataCell(Text(
          assetsModel.date!,
          style: TextStyle(fontSize: 16.sp),
        )),
      ],
    );
  }
}
