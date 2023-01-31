import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_branch.dart';
import 'package:admin/Controllers/add_category.dart';
import 'package:admin/Controllers/add_city.dart';
import 'package:admin/View/create_category.dart';
import 'package:admin/utils/reusabale.dart';

class ShowCategory extends StatelessWidget {
  ShowCategory();
  AddCategoryController controller = Get.find<AddCategoryController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: controller.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                );
              } else {
                var docs = snapshot.data?.docs;
                List<String> data_list = [];
                var ids = [];
                for (int i = 0; i < docs!.length; i++) {
                  data_list.add(docs[i]['name']);
                  ids.add(docs[i]['id']);
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4),
                  ),
                  itemCount: data_list.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTxt(
                                  txt: data_list[index],
                                  txt_style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.name.text = data_list[index];
                                        controller.isUpdate = true;
                                        controller.id = ids[index];
                                        controller.update();
                                        Get.to(CreateCategory());
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.delete(ids[index]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 40.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
