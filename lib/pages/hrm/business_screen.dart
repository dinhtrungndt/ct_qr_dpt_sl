import 'package:flutter/material.dart';

import '../../config/color.dart';
import '../../widget/dialog.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> businessList = ['a'];
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Chọn doanh nghiệp',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          InkWell(
            child: Center(
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    'THÊM',
                    style: TextStyle(color: mainColor),
                  )),
            ),
            onTap: () {
              QuestionDialog(
                      context: context,
                      title: 'Thông báo',
                      conten: 'Bạn có muốn tạo thêm một doanh nghiệp mới?',
                      agreeFunction: () {},
                      refuseFunction: () {})
                  .show();
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: businessList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                );
              })),
    );
  }
}
