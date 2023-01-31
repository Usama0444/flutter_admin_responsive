import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/utils/toast.dart';

import '../Model/assets_model.dart';

class AddAssetsController extends GetxController {
  TextEditingController floor = TextEditingController();
  TextEditingController room = TextEditingController();
  TextEditingController subCategory = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController repRef = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController serNo = TextEditingController();
  TextEditingController assetDes = TextEditingController();
  var assetsImage;
  TextEditingController assetBarcode = TextEditingController();
  String? city;
  String? branch;
  String? category;
  List<AssetsModel> assets = [];

  List<String> cityList = [
    'ISB',
    'RWP',
    'LHR',
  ];
  List<String> branchList = [
    'b1',
    'b2',
    'b3',
  ];
  List<String> categoryList = [
    'c1',
    'c2',
    'c3',
  ];
  bool isUpdate = false;
  var id;
  CollectionReference reference = FirebaseFirestore.instance.collection('assets');
  create() async {
    try {
      print('add');
      if (await checkRecordExisting()) {
        toast('assets barcode already added');
      } else {
        String did = reference.doc().id;
        await reference.doc(did).set({
          'city': city,
          'branch': branch,
          'category': category,
          'floor': floor.text,
          'room': room.text,
          'subCategory': subCategory.text,
          'ref': ref.text,
          'repRef': repRef.text,
          'holderName': holderName.text,
          'serNo': serNo.text,
          'assetsDes': assetDes.text,
          'assetsImage': assetsImage,
          'assetsBarcode': assetBarcode.text,
          'id': did,
        });
        toast('Assets Added!');
        clearAllFields();
      }
    } catch (e) {
      print('Error $e');
      toast('something went wrong!');
    }
  }

  clearAllFields() {
    city = '';
    branch = '';
    category = '';
    floor.text = '';
    room.text = '';
    subCategory.text = '';
    ref.text = '';
    repRef.text = '';
    holderName.text = '';
    serNo.text = '';
    assetDes.text = '';
    assetsImage = null;
    assetBarcode.text = '';
    cityList.clear();
    categoryList.clear();
    branchList.clear();
  }

  Stream<QuerySnapshot> getAll() {
    return reference.snapshots();
  }

  Future<bool> checkRecordExisting() async {
    var data = await reference.where('assetsBarcode', isEqualTo: assetBarcode.text).get();
    if (data.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  edit() async {
    await reference.doc(id).update({
      'city': city,
      'branch': branch,
      'category': category,
      'floor': floor.text,
      'room': room.text,
      'subCategory': subCategory.text,
      'ref': ref.text,
      'repRef': repRef.text,
      'holderName': holderName.text,
      'serNo': serNo.text,
      'assetsDes': assetDes.text,
      'assetsImage': assetsImage,
      'assetsBarcode': assetBarcode.text,
      'id': id,
    });
    clearAllFields();
    toast('Assets updated');
    isUpdate = false;
    update();
  }

  delete(id) async {
    await reference.doc(id).delete();
    toast('Asset deleted');
  }

  fillDropDownList() async {
    cityList.clear();
    categoryList.clear();
    branchList.clear();
    var cityData = await FirebaseFirestore.instance.collection('city').get();
    for (int i = 0; i < cityData.docs.length; i++) {
      cityList.add(cityData.docs[i]['name']);
    }
    //category
    var catData = await FirebaseFirestore.instance.collection('category').get();
    for (int i = 0; i < catData.docs.length; i++) {
      categoryList.add(catData.docs[i]['name']);
    }
    //branch
    var branchData = await FirebaseFirestore.instance.collection('branch').get();
    for (int i = 0; i < branchData.docs.length; i++) {
      branchList.add(branchData.docs[i]['name']);
    }
    update();
  }

  takeAssetImage() async {
    assetsImage = null;
    var pick = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    var img = File(pick!.path);
    var bytes = await img.readAsBytes();
    assetsImage = base64.encode(bytes);
    update();
  }
}
