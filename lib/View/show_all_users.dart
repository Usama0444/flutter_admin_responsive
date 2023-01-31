import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:admin/Controllers/add_user.dart';
import 'package:admin/Model/user_model.dart';
import 'package:admin/View/add_user.dart';
import 'package:admin/utils/reusabale.dart';

class ShowAllUsers extends StatelessWidget {
  ShowAllUsers();
  CreateUserController users = Get.find<CreateUserController>();
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
            stream: users.getAllUsers(),
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
                List<UserModel> user = [];
                var ids = [];
                for (int i = 0; i < docs!.length; i++) {
                  if (docs[i]['username'] != 'admin') {
                    user.add(UserModel(
                      password: docs[i]['password'],
                      username: docs[i]['username'],
                    ));

                    ids.add(docs[i]['uid']);
                  }
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 4),
                  ),
                  itemCount: user.length,
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
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomTxt(
                                      txt: user[index].username,
                                      txt_style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        users.username.text = user[index].username!;
                                        users.password.text = user[index].password!;
                                        users.confirm_password.text = user[index].password!;
                                        users.isUserUpdate = true;
                                        users.id = ids[index];
                                        users.update();
                                        Get.to(AddUser());
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 40.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('press');
                                        users.delete(ids[index]);
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
