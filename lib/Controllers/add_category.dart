import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:admin/utils/toast.dart';

class AddCategoryController extends GetxController {
  TextEditingController name = TextEditingController();
  CollectionReference reference = FirebaseFirestore.instance.collection('category');
  bool isUpdate = false;
  var id;
  create() async {
    try {
      if (await checkRecordExisting()) {
        toast('Category already added');
      } else {
        String did = reference.doc().id;
        await reference.doc(did).set({
          'name': name.text,
          'id': did,
        });
        toast('category Added!');
        name.text = '';
      }
    } catch (e) {
      toast('something went wrong!');
    }
  }

  Stream<QuerySnapshot> getAll() {
    return reference.snapshots();
  }

  Future<bool> checkRecordExisting() async {
    var data = await reference.where('name', isEqualTo: name.text).get();
    if (data.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  edit() async {
    await reference.doc(id).update({
      'name': name.text,
      'id': id,
    });
    name.text = '';
    toast('Category updated');
    isUpdate = false;
    update();
  }

  delete(id) async {
    await reference.doc(id).delete();
    toast('Category deleted');
  }
}
