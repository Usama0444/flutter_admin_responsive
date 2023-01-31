import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/dashboardController.dart';
import 'package:admin/View/show_all_assets.dart';
import 'package:admin/utils/reusabale.dart';

import '../Controllers/add_assets.dart';
import '../Model/assets_model.dart';
import 'add_assets.dart';

class Dashboard extends StatefulWidget {
  Dashboard();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var dropVal;
  var categoryList = ['City', 'Branch', 'Room'];
  var count = [3, 45, 67];
  var dashboardController = Get.put(DashboardController());
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DashboardController>(builder: (context) {
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 100.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 300.w,
                        margin: EdgeInsets.only(right: 50.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                      SizedBox(
                        width: 300.w,
                        child: TextField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                size: 50.sp,
                              )),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              // dashboardController.searchTab();
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 1000.w,
                  height: 200.h,
                  child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200.w,
                          margin: EdgeInsets.only(right: 100.w),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTxt(
                                txt: categoryList[index],
                                txt_style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomTxt(
                                txt: '${count[index]}',
                                txt_style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 1300,
                    height: 650.h,
                    child: ShowDataBySearch(),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ShowDataBySearch extends StatelessWidget {
  ShowDataBySearch();
  AddAssetsController assetss = Get.find<AddAssetsController>();

  List<AssetsModel> assets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              return ListView.builder(
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
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Barcode : ${assets[index].assetBarcode}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Description : ${assets[index].assetsDes}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Floor : ${assets[index].floor}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Branch : ${assets[index].branch}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'City : ${assets[index].city}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    CustomTxt(
                                      txt: 'Category : ${assets[index].category}',
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
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
    );
  }
}
