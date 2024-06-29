import 'package:flutter/material.dart';
import '../../../config/color.dart';
import 'salary_advance_history_screen.dart';

class SalaryAdvanceInforScreen extends StatelessWidget {
  const SalaryAdvanceInforScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 251, 249, 1),
      appBar: AppBar(
        title: const Text(
          'Thông tin ứng lương',
          style: TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Số ngày chấm công',
                    style: TextStyle(fontSize: 20, color: blueBlack),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 5,
                    color: mainColor.withOpacity(0.2),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerRight, child: Text('0/0')),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // primary: mainColor,
                            backgroundColor: mainColor),
                        onPressed: () {
                          //Navigator.pop(context);
                        },
                        child: const Text(
                          "TIẾP TỤC",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Số ngày làm việc không đủ để ứng lương.',
                        style: TextStyle(
                            color: Colors.red, fontStyle: FontStyle.italic),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LỊCH SỬ TẠM ỨNG",
                style:
                    TextStyle(fontSize: 17, color: blueBlack.withOpacity(0.7)),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalaryAdvanceHistoryScreen()));
                },
                child: const Text(
                  "Xem tất cả >",
                  style:
                      TextStyle(fontStyle: FontStyle.italic, color: mainColor),
                ),
              )
            ],
          ),
          const Expanded(
              child: Center(
                  child: Text(
            'Chưa có lịch sử',
            style: TextStyle(fontSize: 20),
          )))
        ]),
      ),
    );
  }
}
