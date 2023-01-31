import 'package:admin/Controllers/add_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_assets.dart';
import 'package:admin/Controllers/login_controller.dart';
import 'package:admin/View/show_all_assets.dart';

import '../utils/reusabale.dart';
import '../utils/toast.dart';
import 'login.dart';

class AddAssets extends StatefulWidget {
  @override
  State<AddAssets> createState() => _AddAssetsState();
}

class _AddAssetsState extends State<AddAssets> {
  AddAssetsController controller = Get.find<AddAssetsController>();
  LoginController loginController = Get.find<LoginController>();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.fillDropDownList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<AddAssetsController>(
        builder: (controller) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(child: MyDropDown(controller: controller, validateTxt: 'City')),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyDropDown(controller: controller, validateTxt: 'Branch'),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          width: 500.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyTextField(
                                controller: controller.floor,
                                form_Height: 80.h,
                                form_width: 250.w,
                                font_size: 16.sp,
                                label_color: Colors.grey[600],
                                lable_Txt: 'Floor',
                                validator_txt: 'Please enter floor',
                              ),
                              MyTextField(
                                controller: controller.room,
                                form_Height: 80.h,
                                form_width: 250.w,
                                font_size: 16.sp,
                                label_color: Colors.grey[600],
                                lable_Txt: 'Room',
                                validator_txt: 'Please enter room',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyDropDown(controller: controller, validateTxt: 'Category'),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyOptionalTextField(
                          controller: controller.subCategory,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'Sub Category',
                          validator_txt: 'Please enter sub category',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MyOptionalTextField(
                          controller: controller.repRef,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'ERP Ref',
                          validator_txt: 'Please enter ERP Ref',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyOptionalTextField(
                          controller: controller.holderName,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'Holder Name',
                          validator_txt: 'Please enter holder name',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyOptionalTextField(
                          controller: controller.serNo,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'Ser No',
                          validator_txt: 'Please enter serial No.',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyOptionalTextField(
                          controller: controller.assetDes,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'Assets Description',
                          validator_txt: 'Please enter assets description',
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // GetBuilder<AddAssetsController>(builder: (controller) {
                        //   return GestureDetector(
                        //     onTap: () {
                        //       controller.takeAssetImage();
                        //     },
                        //     child: SizedBox(
                        //       width: 500.w,
                        //       height: 80.h,
                        //       child: Card(
                        //         elevation: 20,
                        //         child: Padding(
                        //             padding: EdgeInsets.only(left: 10.w),
                        //             child: Row(
                        //               children: [
                        //                 Text(
                        //                   controller.assetsImage == null ? 'Asset Image' : 'Image Picked',
                        //                   style: TextStyle(
                        //                     fontSize: 16.sp,
                        //                     color: controller.assetsImage == null ? Colors.grey[600] : Colors.blue,
                        //                   ),
                        //                 ),
                        //               ],
                        //             )),
                        //       ),
                        //     ),
                        //   );
                        // }),

                        MyOptionalTextField(
                          controller: controller.ref,
                          form_Height: 80.h,
                          form_width: 500.w,
                          font_size: 16.sp,
                          label_color: Colors.grey[600],
                          lable_Txt: 'Ref',
                          validator_txt: 'Please enter ref',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                MyTextField(
                  controller: controller.assetBarcode,
                  form_Height: 80.h,
                  form_width: 1000.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Asset Barcode',
                  validator_txt: 'Please enter asset barcode',
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: 1000.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetBuilder<AddAssetsController>(builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.isUpdate ? controller.edit() : controller.create();
                            }
                          },
                          child: MyButton(
                            btnWidth: 300.w,
                            btnHeight: 60.h,
                            btnColor: Colors.grey[500],
                            btnTxt: controller.isUpdate ? 'Update' : 'Save',
                          ),
                        );
                      }),
                      GestureDetector(
                        onTap: () {
                          Get.to(ShowAllAssets());
                        },
                        child: MyButton(
                          btnWidth: 300.w,
                          btnHeight: 60.h,
                          btnColor: Colors.grey[500],
                          btnTxt: 'Show All',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
