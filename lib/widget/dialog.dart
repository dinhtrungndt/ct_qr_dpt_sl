import 'package:flutter/material.dart';
import '../config/color.dart';

Widget closeDialog(BuildContext context, String tittle, String content) {
  return Dialog(
      alignment: Alignment.center,
      backgroundColor: const Color.fromRGBO(235, 235, 245, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                tittle,
                style: const TextStyle(fontSize: 20, color: blueBlack),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                content,
                style:
                    TextStyle(fontSize: 16, color: blueBlack.withOpacity(0.8)),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      // shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      // primary: mainColor,
                      backgroundColor: mainColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Đóng",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )),
            ),
          ],
        ),
      ));
}

class QuestionDialog {
  QuestionDialog({
    required this.context,
    required this.title,
    required this.conten,
    required this.agreeFunction,
    required this.refuseFunction,
  });
  final String title;
  final String conten;
  final BuildContext context;
  final Function() agreeFunction;
  final Function() refuseFunction;

  show() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text('Thông báo',
                      style: TextStyle(fontSize: 23),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Text(conten,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]!),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                // primary: mainColor,
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                side: BorderSide(color: mainColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Hủy',
                                  style: TextStyle(fontSize: 17)),
                              onPressed: () {
                                Navigator.pop(context);
                                refuseFunction();
                              }),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  // primary: mainColor,
                                  backgroundColor: mainColor),
                              onPressed: () {
                                Navigator.pop(context);
                                agreeFunction();
                              },
                              child: const Text(
                                "Đồng ý",
                                style: TextStyle(fontSize: 17),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}

Future showProgressDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                height: 60,
                width: 60,
                child: const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(color: mainColor),
                  ),
                ),
              ),
            ));
      });
}
