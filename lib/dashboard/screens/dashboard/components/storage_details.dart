import 'package:admin/Controllers/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatefulWidget {
  StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {
  var controller = Get.put(DashboardController());

  var lst = [
    'Branch',
    'Category',
    'City',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.dataCounts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      List<int> countsList = [
        controller.branchCount,
        controller.categoryCount,
        controller.cityCount,
      ];
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Storage Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Chart(),
            SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return StorageInfoCard(
                      svgSrc: "assets/icons/Documents.svg",
                      title: lst[index],
                      amountOfFiles: countsList[index].toString(),
                      numOfFiles: 21321,
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
