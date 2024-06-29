import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../config/color.dart';

import '../../../method/hrm_method.dart';
import 'chosse_calendar_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              buildAppbar(context),
              const SizedBox(height: 15),
              buildDay(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        //const SizedBox(height: 10),
        buildSelectDay(DateTime.now())
      ],
    );
  }
}

Widget buildAppbar(BuildContext context) {
  return Row(
    children: [
      const Icon(Icons.date_range, color: Colors.grey),
      const SizedBox(width: 10),
      Text(
        'Th.${DateFormat('MM yyyy').format(DateTime.now())}',
        style: const TextStyle(fontSize: 18),
      ),
      const Expanded(child: SizedBox.shrink()),
      InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChooseCalendarScreen())),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.menu, size: 25),
          // child: PopupMenuButton(
          //   padding: const EdgeInsets.all(0),
          //  icon: const Icon(Icons.menu, size: 25),
          //   onSelected: (int index) {
          //   onSelectedMenuItem(context, index);
          //   },
          // itemBuilder: (context) => const [
          // PopupMenuItem(
          //   value: 1,
          //   child: Text('Thêm nhân viên'),
          // ),
          // PopupMenuItem(
          //   value: 2,
          //   child: Text('Tạo ca'),
          // ),
          // PopupMenuItem(
          //   value: 3,
          //   child: Text('Quản lý yêu cầu'),
          // ),
          // PopupMenuItem(
          //   value: 4,
          //   child: Text('Chấm công'),
          // ),
          // PopupMenuItem(
          //   value: 5,
          //   child: Text('Phân ca làm'),
          // ),
          // PopupMenuItem(
          //   value: 6,
          //   child: Text('Phiếu lương'),
          // ),
          //  ],
          //  )
          // child: const Icon(
          //   Icons.menu,
          //   size: 25,
          // ),
        ),
      )
    ],
  );
}

Widget buildDay() {
  DateTime now = DateTime.now();
  int day = now.day;
// DateTime now=DateTime.utc(2022, 12, 9);
  int firstDayOfWeek = now.weekday;
  // DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday-1));
  DateFormat('EEEE').format(now);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      for (int i = 0; i < 7; i++)
        Container(
          width: 40,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  getDay(i + 1),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                (now.subtract(Duration(days: firstDayOfWeek - 1 - i)).day !=
                        day)
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: Center(
                          child: Text(
                            now
                                .subtract(
                                    Duration(days: firstDayOfWeek - 1 - i))
                                .day
                                .toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                    : Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: mainColor),
                        child: Center(
                          child: Text(
                            now
                                .subtract(
                                    Duration(days: firstDayOfWeek - 1 - i))
                                .day
                                .toString(),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
              ]),
        )
    ],
  );
}

Widget buildSelectDay(DateTime date) {
  initializeDateFormatting();
  DateFormat dateFormat = DateFormat.EEEE('vi');
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${dateFormat.format(date)}, ${DateFormat('dd MM').format(date)}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: const Center(
              child: Text(
            'Không có sự kiện nào',
            style: TextStyle(color: Colors.grey),
          )),
        ),
      ],
    ),
  );
}

onSelectedMenuItem(BuildContext context, int index) {
  // if (index == 1) {
  //   Get.to(() => const AddPersonnelScreen());}
  // else if (index == 2) {
  //   Get.to(() => const CreateShiftSreen());
  // } else if (index == 3) {
  //   Get.to(() => const RequestManagementScreen());
  // } else if (index == 4) {
  //   Get.to(() => const TimeKeepingScreen());
  // } else if (index == 5) {
  //   Get.to(() => const ShiftAssignmentScreen());
  // } else if (index == 6) {
  //   Get.to(() => const PayCheckScreen());
  // }
}
