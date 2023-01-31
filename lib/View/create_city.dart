import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_city.dart';
import 'package:admin/View/show_city.dart';
import 'package:admin/utils/reusabale.dart';

class CreateCity extends StatelessWidget {
  CreateCity();
  var controller = Get.find<AddCityController>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: MyTextField(
                  controller: controller.name,
                  form_Height: 80.h,
                  form_width: 350.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'City name',
                  validator_txt: 'Please enter city name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ShowCity());
                      },
                      child: MyButton(
                        btnWidth: 150.w,
                        btnHeight: 70.h,
                        btnColor: Colors.grey[500],
                        btnTxt: 'Show cities',
                      ),
                    ),
                    GetBuilder<AddCityController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.isUpdate ? controller.edit() : controller.create();
                          }
                        },
                        child: MyButton(
                          btnWidth: 150.w,
                          btnHeight: 70.h,
                          btnColor: Colors.grey[500],
                          btnTxt: controller.isUpdate ? 'Update' : 'Add',
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
