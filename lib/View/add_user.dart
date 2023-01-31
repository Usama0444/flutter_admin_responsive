import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_user.dart';
import 'package:admin/View/show_all_users.dart';
import 'package:admin/utils/reusabale.dart';

class AddUser extends StatelessWidget {
  AddUser();
  CreateUserController controller = Get.find<CreateUserController>();
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
                  controller: controller.username,
                  form_Height: 90.h,
                  form_width: 500.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Enter username',
                  validator_txt: 'Please enter username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MyTextField(
                  controller: controller.password,
                  form_Height: 90.h,
                  form_width: 500.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Password',
                  validator_txt: 'Please enter password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MyTextField(
                  controller: controller.confirm_password,
                  form_Height: 90.h,
                  form_width: 500.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Confirm password',
                  validator_txt: 'Please enter confirm password',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 500.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ShowAllUsers());
                        },
                        child: MyButton(
                          btnWidth: 150.w,
                          btnHeight: 70.h,
                          btnColor: Colors.grey[500],
                          btnTxt: 'Show all Users',
                        ),
                      ),
                      GetBuilder<CreateUserController>(builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (controller.isUserUpdate) {
                                controller.edit();
                              } else {
                                controller.addUser();
                              }
                            }
                          },
                          child: MyButton(
                            btnWidth: 150.w,
                            btnHeight: 70.h,
                            btnColor: Colors.grey[500],
                            btnTxt: controller.isUserUpdate ? 'Update' : 'Register',
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
