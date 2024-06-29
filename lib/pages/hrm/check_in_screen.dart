import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/color.dart';

import '../../method/hrm_method.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.name});
  final String name;
  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2fbf8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(children: [
        Container(
          height: 30,
          width: double.infinity,
          color: Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  child: const Icon(Icons.arrow_back_ios,
                      color: Color(0xff2bc37b))),
              onTap: () {
                setState(() {
                  date = DateTime(date.year, date.month - 1, date.day);
                });
              },
            ),
            Container(
                alignment: Alignment.center,
                width: 130,
                child: Text(DateFormat('MM,yyyy').format(date))),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                child: const Icon(Icons.arrow_forward_ios,
                    color: Color(0xff2bc37b)),
              ),
              onTap: () {
                setState(() {
                  date = DateTime(date.year, date.month + 1, date.day);
                });
              },
            ),
          ]),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: buildCheckInList(context, date),
        ))
      ]),
    );
  }
}

Widget buildCheckInList(BuildContext context, DateTime date) {
  int numberDay = daysInMonth(date);
  return Column(children: [
    for (int i = 1; i <= numberDay; i++)
      buildCheckInItem(context, DateTime(date.year, date.month, i))
  ]);
}

Widget buildCheckInItem(BuildContext context, DateTime date) {
  int d = date.weekday;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
    child: Row(children: [
      Column(
        children: [
          Text(
            getDay(d),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('dd').format(date),
            style: const TextStyle(color: Color(0xff2bc37b), fontSize: 27),
          )
        ],
      ),
      const SizedBox(width: 20),
      Expanded(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(d != 7 ? 'Ca hành chính' : 'Ca chủ nhật',
                  style: const TextStyle(fontSize: 16)),
              Text(
                d != 7 ? '(08:00-17:30)' : '08:00-12:00',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              Text(
                'Asia/Ho_Chi_Minh',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              Text(
                '(GMT+07:00)',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              )
            ],
          ),
          InkWell(
            child: Row(
              children: [
                Column(
                  children: [
                    const Text('08:00'),
                    const SizedBox(height: 5),
                    Text(d != 7 ? '17:30' : '12:00'),
                  ],
                ),
                const Column(
                  children: [
                    Icon(Icons.crop_square_sharp, color: mainColor),
                    Icon(Icons.crop_square_sharp, color: mainColor)
                  ],
                ),
                const Icon(
                  Icons.more_time,
                  color: mainColor,
                )
              ],
            ),
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                        alignment: Alignment.center,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Center(
                                child: const Text('Thông báo',
                                    style: const TextStyle(fontSize: 23),
                                    textAlign: TextAlign.center),
                              ),
                              const SizedBox(height: 20),
                              Text('Bạn muốn check-in cho nhân viên này?',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[800]!),
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 10),
                              const Text('Lý do',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 70,
                                width: double.infinity,
                                child: TextFormField(
                                  cursorColor: backgroundColor,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 15),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            side: const BorderSide(
                                                color: mainColor, width: 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: const Text('HỦY',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: mainColor)),
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              //primary: mainColor,
                                              backgroundColor: mainColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "XÁC NHẬN",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  });
            },
          )
        ]),
      ))
    ]),
  );
}
