import 'package:admin/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/assets_model.dart';

class DashboardController extends GetxController {
  CollectionReference assetsRef = FirebaseFirestore.instance.collection('assets');
  CollectionReference branchRef = FirebaseFirestore.instance.collection('branch');
  CollectionReference categoryRef = FirebaseFirestore.instance.collection('category');
  CollectionReference cityRef = FirebaseFirestore.instance.collection('city');
  int cityCount = 0;
  int categoryCount = 0;
  int branchCount = 0;
  List<AssetsModel> assetsModel = [];
  List<AssetsModel> searchData = [];
  TextEditingController searchInputTypeData = TextEditingController();
  dataCounts() async {
    try {
      var city = await cityRef.get();
      cityCount = city.size;
      var category = await categoryRef.get();
      categoryCount = category.size;
      var branch = await branchRef.get();
      branchCount = branch.size;
      update();
      print('branch $branchCount');
      assetsRecord();
    } catch (e) {
      toast('$e');
    }
  }

  Future<void> assetsRecord() async {
    try {
      var snapshot = await assetsRef.get();
      assetsModel.clear();
      var docs = snapshot.docs;
      for (int i = 0; i < docs.length; i++) {
        assetsModel.add(AssetsModel(
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
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchAssetsRecord() async {
    try {
      searchData.clear();
      for (int i = 0; i < assetsModel.length; i++) {
        if (assetsModel[i].city?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        } else if (assetsModel[i].floor?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        } else if (assetsModel[i].room?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        } else if (assetsModel[i].branch?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        } else if (assetsModel[i].category?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        } else if (assetsModel[i].holdername?.toLowerCase() == searchInputTypeData.text.toLowerCase()) {
          searchData.add(assetsModel[i]);
        }
      }
      update();
    } catch (e) {
      toast(e.toString());
    }
  }
}
