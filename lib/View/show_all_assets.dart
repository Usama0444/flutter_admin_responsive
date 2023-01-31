import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
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
      // assets[i].assetsImg.toString(),
      'ASSET BARCODE',
    ]);
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
        // assets[i].assetsImg.toString(),
        assets[i].assetBarcode.toString(),
      ]);
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
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
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
                  ));
                  ids.add(docs[i]['id']);
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2),
                  ),
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                assets[index].assetsImg != null
                                    ? Expanded(
                                        flex: 1,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.h),
                                            child: Image.memory(
                                              base64.decode(assets[index].assetsImg!),
                                              fit: BoxFit.cover,
                                              width: 80.w,
                                              height: 120.h,
                                            )),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTxt(
                                        txt: 'Holder Name : ${assets[index].holdername}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'Barcode : ${assets[index].assetBarcode}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'Description : ${assets[index].assetsDes}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'Floor : ${assets[index].floor}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'Branch : ${assets[index].branch}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'City : ${assets[index].city}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CustomTxt(
                                        txt: 'Category : ${assets[index].category}',
                                        txt_style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.h),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            assetss.assetBarcode.text = assets[index].assetBarcode!;
                                            assetss.assetDes.text = assets[index].assetsDes!;
                                            assetss.assetsImage = assets[index].assetsImg!;
                                            assetss.floor.text = assets[index].floor!;
                                            assetss.room.text = assets[index].room!;
                                            assetss.subCategory.text = assets[index].subCategory!;
                                            assetss.ref.text = assets[index].ref!;
                                            assetss.repRef.text = assets[index].erpRef!;
                                            assetss.holderName.text = assets[index].holdername!;
                                            assetss.serNo.text = assets[index].serNo!;
                                            assetss.id = ids[index];
                                            assetss.isUpdate = true;
                                            assetss.city = assets[index].city;
                                            assetss.branch = assets[index].branch;
                                            assetss.category = assets[index].category;
                                            assetss.update();
                                            Get.to(AddAssets());
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: 40.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            assetss.delete(ids[index]);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 40.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
