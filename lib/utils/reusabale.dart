import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controllers/add_assets.dart';

class MyTextField extends StatefulWidget {
  String lable_Txt;
  double font_size;
  var label_color;
  String validator_txt;
  double form_width;
  double form_Height;
  TextEditingController controller;
  MyTextField({
    required this.font_size,
    required this.label_color,
    required this.lable_Txt,
    required this.validator_txt,
    required this.form_Height,
    required this.form_width,
    required this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: form_Height,
      width: widget.form_width,
      child: Card(
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.lable_Txt == 'Password' || widget.lable_Txt == 'Confirm password' ? obs : false,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.lable_Txt,
              suffixIcon: widget.lable_Txt == 'Password' || widget.lable_Txt == 'Confirm password'
                  ? !obs
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obs) {
                                obs = false;
                              } else {
                                obs = true;
                              }
                            });
                          },
                          child: const Icon(Icons.visibility_off))
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obs) {
                                obs = false;
                              } else {
                                obs = true;
                              }
                            });
                          },
                          child: const Icon(Icons.visibility))
                  : const Text(''),
              hintStyle: TextStyle(
                fontSize: widget.font_size,
                color: widget.label_color,
              ),
              border: InputBorder.none,
            ),
            validator: ((value) {
              if (value!.isEmpty) {
                return widget.validator_txt;
              }
              return null;
            }),
          ),
        ),
      ),
    );
  }
}

class MyOptionalTextField extends StatefulWidget {
  String lable_Txt;
  double font_size;
  var label_color;
  String validator_txt;
  double form_width;
  double form_Height;
  TextEditingController controller;
  MyOptionalTextField({
    required this.font_size,
    required this.label_color,
    required this.lable_Txt,
    required this.validator_txt,
    required this.form_Height,
    required this.form_width,
    required this.controller,
  });

  @override
  State<MyOptionalTextField> createState() => _MyOptionalTextFieldState();
}

class _MyOptionalTextFieldState extends State<MyOptionalTextField> {
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.form_width,
      child: Card(
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: TextField(
            controller: widget.controller,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.lable_Txt,
              hintStyle: TextStyle(
                fontSize: widget.font_size,
                color: widget.label_color,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  var btnWidth, btnHeight, btnColor, btnTxt;
  MyButton({
    required this.btnColor,
    this.btnHeight,
    this.btnWidth,
    required this.btnTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          btnTxt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class CustomTxt extends StatelessWidget {
  var txt;
  TextStyle txt_style;
  CustomTxt({required this.txt, required this.txt_style});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: txt_style,
    );
  }
}

class MyDropDown extends StatelessWidget {
  String validateTxt;
  AddAssetsController controller;
  MyDropDown({
    required this.controller,
    required this.validateTxt,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.w,
      child: Card(
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: DropdownButtonFormField<String>(
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.black,
            value: validateTxt == 'City'
                ? controller.city
                : validateTxt == 'Category'
                    ? controller.category
                    : controller.branch,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black),
            hint: Text(
              validateTxt,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            dropdownColor: Colors.white,
            onChanged: (value) {
              if (validateTxt == 'City') {
                controller.city = value;
              } else if (validateTxt == 'Category') {
                controller.category = value;
              } else {
                controller.branch = value;
              }
              controller.update();
            },
            validator: (value) => value == null ? '$validateTxt required' : null,
            items: validateTxt == 'City'
                ? controller.cityList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                : validateTxt == 'Category'
                    ? controller.categoryList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : controller.branchList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
          ),
        ),
      ),
    );
  }
}
