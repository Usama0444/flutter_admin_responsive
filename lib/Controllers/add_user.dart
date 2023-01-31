import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/View/add_user.dart';
import 'package:admin/utils/toast.dart';

import '../View/home_page.dart';

class CreateUserController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  bool isUserUpdate = false;
  var id;
  var userCollectionRef = FirebaseFirestore.instance.collection('users');

  addUser() async {
    try {
      if (await checkRecordExisting()) {
        toast('User already added');
      } else {
        if (password.text == confirm_password.text) {
          String uid = userCollectionRef.doc().id;
          await userCollectionRef.doc(uid).set({
            'username': username.text,
            'password': password.text,
            'uid': uid,
          });
          toast('User Created Successfully!');
          clearAllFields();
        } else {
          toast('password and confirm password not match');
        }
      }
    } catch (e) {
      toast('something went wrong!');
    }
  }

  clearAllFields() {
    username.text = '';
    password.text = '';
    confirm_password.text = '';
    update();
  }

  Stream<QuerySnapshot> getAllUsers() {
    return userCollectionRef.snapshots();
  }

  Future<bool> checkRecordExisting() async {
    var data = await userCollectionRef.where('username', isEqualTo: username.text).get();
    if (data.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  edit() async {
    await userCollectionRef.doc(id).update({
      'username': username.text,
      'password': password.text,
      'uid': id,
    });
    clearAllFields();
    toast('User updated');
    isUserUpdate = false;
    update();
  }

  delete(uid) async {
    await userCollectionRef.doc(uid).delete();
    toast('user deleted');
  }
}
