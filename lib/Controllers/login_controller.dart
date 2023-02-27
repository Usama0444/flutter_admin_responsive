import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/View/add_assets.dart';
import 'package:admin/View/home_page.dart';
import 'package:admin/dashboard/screens/main/main_screen.dart';
import 'package:admin/utils/toast.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var userCollectionRef = FirebaseFirestore.instance.collection('users');
  bool isAdminLogin = false;
  userLogin() async {
    try {
      var isMatch = await userCollectionRef
          .where(
            'username',
            isEqualTo: 'admin',
          )
          .where(
            'password',
            isEqualTo: 'admin@123',
          )
          .get();
      if (isMatch.docs.isNotEmpty) {
        toast('Login Successfully!');
        if (username.text == 'admin') {
          isAdminLogin = true;
          Get.offAll(MainScreen());
        } else {
          isAdminLogin = false;
          Get.offAll(AddAssets());
        }
        clearAllFields();
      } else {
        toast('User Not Found!');
      }
    } catch (e) {
      print('Error $e');
      toast('something went wrong!');
    }
  }

  clearAllFields() {
    username.text = '';
    password.text = '';
    update();
  }
}
