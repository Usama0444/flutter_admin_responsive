import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_branch.dart';
import 'package:admin/View/show_branches.dart';
import 'package:admin/utils/reusabale.dart';

class CreateBrach extends StatelessWidget {
  CreateBrach();
  var controller = Get.find<AddBranchController>();
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
                  lable_Txt: 'Branch name',
                  validator_txt: 'Please enter branch name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 350.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ShowBranches());
                        },
                        child: MyButton(
                          btnWidth: 150.w,
                          btnHeight: 70.h,
                          btnColor: Colors.grey[500],
                          btnTxt: 'Show branches',
                        ),
                      ),
                      GetBuilder<AddBranchController>(builder: (controller) {
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
