import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/login_controller.dart';
import 'package:admin/View/home_page.dart';
import 'package:admin/utils/reusabale.dart';

import '../Controllers/add_user.dart';

class Login extends StatelessWidget {
  Login();
  LoginController controller = Get.find<LoginController>();
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
                  form_Height: 80.h,
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
                  form_Height: 80.h,
                  form_width: 500.w,
                  font_size: 16.sp,
                  label_color: Colors.grey[600],
                  lable_Txt: 'Password',
                  validator_txt: 'Please enter password',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.userLogin();
                    }
                  },
                  child: MyButton(
                    btnWidth: 350.w,
                    btnHeight: 70.h,
                    btnColor: Colors.grey[500],
                    btnTxt: 'Sign in',
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
