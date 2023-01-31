import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TestScreen123 extends StatefulWidget {
  const TestScreen123({Key? key}) : super(key: key);

  @override
  State<TestScreen123> createState() => _TestScreen123State();
}

class _TestScreen123State extends State<TestScreen123> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: MaterialButton(
          color: Colors.redAccent,
          onPressed: (){
            List<List<String>> list=[
              ['Name', 'RollNo', 'City'],
              ['Ali', '101', 'Rwp'],
              ['Noman', '102', 'Lhr'],
              ['Aslam', '103', 'Mult']
            ];
            saveList(list);
          },
          child: const Text('Perform'),
        ),
      ),
    );
  }
  saveList(List<List<String>> list) async {
    String csvData = ListToCsvConverter().convert(list);
    final String directory = (await getApplicationSupportDirectory()).path;
    print(directory);
    final path = "$directory/csv-${DateTime.now()}.csv";
    print('File Saved in Given Path=$path');
    final File file = File(path);
    await file.writeAsString(csvData);
    shareFile(file);
  }


 shareFile(File file){
    Share.shareFiles([file.path]);
  }

}
