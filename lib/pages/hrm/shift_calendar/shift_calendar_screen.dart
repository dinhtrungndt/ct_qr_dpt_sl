import 'package:erp/base/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/hrm_model/attendance_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'bloc/shift_calendar_bloc.dart';
import 'shift_information_screen.dart';

class ShiftCalendarScreen extends StatefulWidget {
  const ShiftCalendarScreen({super.key});

  @override
  State<ShiftCalendarScreen> createState() => _ShiftCalendarScreenState();
}

class _ShiftCalendarScreenState extends State<ShiftCalendarScreen> {
  late ShiftCalendarBloc shiftCalendarBloc;
  @override
  void initState() {
    shiftCalendarBloc = BlocProvider.of<ShiftCalendarBloc>(context);
    shiftCalendarBloc.add(ShiftCalendarLoadWeek());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0fff6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Lịch công',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          BlocBuilder<ShiftCalendarBloc, ShiftCalendarState>(
              builder: (context, state) {
            return InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: mainColor, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      shiftCalendarBloc
                                          .add(ShiftCalendarLoadToday());
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Hôm nay',
                                        style: TextStyle(color: mainColor)),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: mainColor, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      shiftCalendarBloc
                                          .add(ShiftCalendarLoadWeek());
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tuần này',
                                        style: TextStyle(color: mainColor)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: SfDateRangePicker(
                                  headerStyle: const DateRangePickerHeaderStyle(
                                      backgroundColor: Colors.white,
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                          fontSize: 22, color: Colors.black)),
                                  headerHeight: 50,
                                  selectionColor: mainColor,
                                  selectionTextStyle:
                                      const TextStyle(color: Colors.white),
                                  rangeTextStyle:
                                      const TextStyle(color: Colors.white),
                                  todayHighlightColor: mainColor,
                                  rangeSelectionColor: mainColor,
                                  startRangeSelectionColor: mainColor,
                                  endRangeSelectionColor: mainColor,
                                  view: DateRangePickerView.month,
                                  showActionButtons: true,
                                  initialSelectedRange: PickerDateRange(
                                      DateTime.now(), DateTime.now()),
                                  selectionMode: DateRangePickerSelectionMode
                                      .extendableRange,
                                  allowViewNavigation: true,
                                  onSubmit: (Object? value) {
                                    Navigator.pop(context);
                                    if (value == null) return;
                                    PickerDateRange pickerDateRange =
                                        value as PickerDateRange;

                                    shiftCalendarBloc.add(
                                        ShiftCalendarLoadRangeDate(
                                            fromDate:
                                                pickerDateRange.startDate!,
                                            toDate: pickerDateRange.endDate!));
                                  },
                                  onCancel: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ));
                    });
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: mainColor, size: 22),
                  const SizedBox(width: 5),
                  Center(
                      child: Text(state.selectDateText,
                          style:
                              const TextStyle(color: blueGrey1, fontSize: 16))),
                  Icon(Icons.arrow_drop_down,
                      color: Colors.grey[600], size: 27),
                  const SizedBox(width: 10),
                ],
              ),
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ShiftCalendarBloc, ShiftCalendarState>(
                  // buildWhen: (previous, current) => current is ShiftCalendarLoaded && previous != current,
                  builder: (context, state) {
                if (state.loadStatus == LoadShiftCalendarStatus.success) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [
                      for (var item in state.listAttendanceModel)
                        buildShiftCalendarItem(context, item)
                    ],
                  ));
                } else if (state.loadStatus ==
                    LoadShiftCalendarStatus.loading) {
                  return const Loading();
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildShiftCalendarItem(
    BuildContext context, AttendanceModel attendanceModel) {
  int d = attendanceModel.day.weekday;
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
            DateFormat('dd').format(attendanceModel.day),
            style: const TextStyle(
                color: Color(0xff30c47f),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      const SizedBox(width: 20),
      Expanded(
          child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShiftInformationScreen(
                    attendanceModel: attendanceModel, edit: false)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: _buildItem(attendanceModel),
        ),
      ))
    ]),
  );
}

String getShiftStatusText(
    DateTime day, String start, String checkin, String checkout) {
  if (day.compareTo(DateTime.now()) > 0) return 'Chưa đến ca làm';
  // if (id == 1) return 'Chưa vào/ra ca';
  // if (id == 2) return 'Chưa ra ca';
  // if (id == 3) return 'Trễ giờ,về sớm';
  return 'Đúng giờ';
}

Color getShiftStatusColor(int id) {
  if (id == 0) return Colors.blueGrey[100]!;
  if (id == 1) return Colors.blueGrey[200]!;
  if (id == 2) return Colors.blueGrey[300]!;
  if (id == 3) return Colors.orange;
  return mainColor.withOpacity(0.8);
}

Widget _buildItem(AttendanceModel attendanceModel) {
  String label;
  Color color;
  if (attendanceModel.day.compareTo(DateTime.now()) > 0) {
    label = 'Chưa đến ca làm';
    color = Colors.blueGrey[100]!;
  } else if (attendanceModel.checkout == null) {
    label = 'Chưa vào/ra ca';
    color = Color.fromARGB(255, 255, 97, 86);
  } else {
    label = 'Đúng giờ';
    color = mainColor;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color: color, width: 3, height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      capitalize(attendanceModel.shift)
                          .replaceAll("", "\u{200B}"),
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, color: Colors.blueGrey[700])),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          attendanceModel.checkin == null
                              ? '__'
                              : attendanceModel.checkin!.substring(0, 5),
                          style: TextStyle(fontSize: 15, color: color)),
                      Text(
                          attendanceModel.checkout == null
                              ? ' - __'
                              : ' - ${attendanceModel.checkout!.substring(0, 5)}',
                          style: TextStyle(fontSize: 15, color: color)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ))
          ]),
      const SizedBox(height: 5),
      Container(height: 1, color: Colors.grey[300]),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.pin_drop, size: 17, color: Colors.grey),
            const SizedBox(width: 5),
            const Expanded(child: Text('', style: TextStyle(fontSize: 13))),
            const Icon(Icons.access_time, color: Colors.grey, size: 17),
            const SizedBox(width: 5),
            Text(
                '${attendanceModel.startShift.substring(0, 5)}-${attendanceModel.endShift.substring(0, 5)}',
                style: const TextStyle(fontSize: 13)),
          ],
        ),
      )
    ],
  );
}
