import 'package:erp/base/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/hrm_model/attendance_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'bloc/timekeeping_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeKeepingScreen extends StatefulWidget {
  const TimeKeepingScreen({super.key});

  @override
  State<TimeKeepingScreen> createState() => _TimeKeepingScreenState();
}

class _TimeKeepingScreenState extends State<TimeKeepingScreen> {
  late TimekeepingBloc timekeepingBloc;
  @override
  void initState() {
    timekeepingBloc = BlocProvider.of<TimekeepingBloc>(context);
    timekeepingBloc.add(InitialTimekeepingEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.attendance,
            style: const TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          actions: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.change_circle_outlined),
              ),
              onTap: () {
                EasyLoading.showSuccess('Refresh success');
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: BlocBuilder<TimekeepingBloc, TimekeepingState>(
                builder: (context, state) {
                  return InkWell(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
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
                                                      color: mainColor,
                                                      width: 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  timekeepingBloc.add(
                                                      ChooseDateRangeEvent(
                                                          fromDate:
                                                              DateTime.now(),
                                                          toDate:
                                                              DateTime.now()));
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .today,
                                                    style: const TextStyle(
                                                        color: mainColor)),
                                              ),
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      color: mainColor,
                                                      width: 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  DateTime now = DateTime.now();
                                                  DateTime fromDate =
                                                      now.subtract(Duration(
                                                          days:
                                                              now.weekday - 1));
                                                  DateTime toDate = DateTime(
                                                          fromDate.year,
                                                          fromDate.month,
                                                          fromDate.day)
                                                      .add(const Duration(
                                                          days: 6));
                                                  timekeepingBloc.add(
                                                      ChooseDateRangeEvent(
                                                          fromDate: fromDate,
                                                          toDate: toDate));
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .thisWeek,
                                                    style: const TextStyle(
                                                        color: mainColor)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 350,
                                            width: double.infinity,
                                            child: SfDateRangePicker(
                                              headerStyle:
                                                  const DateRangePickerHeaderStyle(
                                                      backgroundColor:
                                                          Colors.white,
                                                      textAlign:
                                                          TextAlign.center,
                                                      textStyle: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.black)),
                                              headerHeight: 50,
                                              selectionColor: mainColor,
                                              selectionTextStyle:
                                                  const TextStyle(
                                                      color: Colors.white),
                                              rangeTextStyle: const TextStyle(
                                                  color: Colors.white),
                                              todayHighlightColor: mainColor,
                                              rangeSelectionColor: mainColor,
                                              startRangeSelectionColor:
                                                  mainColor,
                                              endRangeSelectionColor: mainColor,
                                              view: DateRangePickerView.month,
                                              showActionButtons: true,
                                              initialSelectedRange:
                                                  PickerDateRange(
                                                      DateTime.now(),
                                                      DateTime.now()),
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .extendableRange,
                                              allowViewNavigation: true,
                                              onSubmit: (Object? value) {
                                                Navigator.pop(context);
                                                if (value == null) return;
                                                PickerDateRange
                                                    pickerDateRange =
                                                    value as PickerDateRange;
                                                timekeepingBloc.add(
                                                    ChooseDateRangeEvent(
                                                        fromDate:
                                                            pickerDateRange
                                                                .startDate!,
                                                        toDate: pickerDateRange
                                                            .endDate!));
                                              },
                                              onCancel: () =>
                                                  Navigator.pop(context),
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
                                  child: Text(
                                      dateRange(state.fromDate, state.toDate),
                                      style: const TextStyle(
                                          color: blueGrey1, fontSize: 16))),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey[600], size: 27),
                              const SizedBox(width: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            _buildTabar(context),
            Expanded(
              child: Container(
                color: lightGreen1,
                child: BlocBuilder<TimekeepingBloc, TimekeepingState>(
                    builder: (context, state) {
                  if (state.status == TimekeepingStatus.success) {
                    return TabBarView(
                      children: [
                        _buildInOutItem(state.listAttendanceModel, context),
                        _buildTimeSheetsList(state.listAttendanceModel)
                      ],
                    );
                  } else if (state.status == TimekeepingStatus.loading) {
                    return const Loading();
                  } else {
                    return const TabBarView(
                      children: [SizedBox.shrink(), SizedBox.shrink()],
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildTabar(BuildContext context) {
  //TimeKeepingController controller = Get.find<TimeKeepingController>();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    height: 30,
    child: TabBar(
        // onTap: ((value) => controller.setTabIndex(value)),
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: blueGrey3,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: [
          Tab(
              child: Center(
            child: Text(AppLocalizations.of(context)!.inOut,
                style: const TextStyle(fontSize: 17)),
          )),
          Tab(
              child: Center(
            child: Text(AppLocalizations.of(context)!.statistical,
                style: const TextStyle(fontSize: 17)),
          )),
        ]),
  );
}

Widget _buildInOutItem(
    List<AttendanceModel> listAttendanceModel, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        for (var attendanceModel in listAttendanceModel)
          if (attendanceModel.checkin != null ||
              attendanceModel.checkout != null)
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${getToday(attendanceModel.day, context)}, ${DateFormat('dd.MM').format(attendanceModel.day)}',
                      style: TextStyle(
                          fontSize: 18, color: blueBlack.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 25),
                    if (attendanceModel.checkout != null)
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              attendanceModel.deviceOut == 0
                                  ? Icons.phone_android
                                  : Icons.fax_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attendanceModel.fullName,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 1),
                                Text(
                                    '${AppLocalizations.of(context)!.checkOut} - ${capitalize(attendanceModel.shift)}',
                                    style: const TextStyle(color: blueGrey1)),
                                Text(
                                    '(${attendanceModel.startShift.substring(0, 5)}-${attendanceModel.endShift.substring(0, 5)})',
                                    style: const TextStyle(color: blueGrey1)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: blueGrey3.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              attendanceModel.checkout!.substring(0, 5),
                              style: const TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    if (attendanceModel.checkin != null)
                      const SizedBox(height: 10),
                    if (attendanceModel.checkin != null)
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              attendanceModel.deviceOut == 0
                                  ? Icons.phone_android
                                  : Icons.fax_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attendanceModel.fullName,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 1),
                                Text(
                                    '${AppLocalizations.of(context)!.checkIn} - ${capitalize(attendanceModel.shift)}',
                                    style: const TextStyle(color: blueGrey1)),
                                Text(
                                    '(${attendanceModel.startShift.substring(0, 5)}-${attendanceModel.endShift.substring(0, 5)})',
                                    style: const TextStyle(color: blueGrey1)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: blueGrey3.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              attendanceModel.checkin!.substring(0, 5),
                              style: const TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      )
                  ],
                )),
      ],
    ),
  );
}

Widget _buildTimeSheetsList(List<AttendanceModel> listAttendanceModel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // for (var m in listTimeSheetModel) _buildTimeSheetsItem(m),
        // if (nAttendanceInvalid >= 0)
        SizedBox(height: 20),
        _buildAttendanceInvalid(
            'Ngày công thực tế',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.workDay!)
                .toStringAsFixed(2)),
            'ngày',
            true),
        _buildAttendanceInvalid(
            'Giờ công thực tế',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.workHour!)
                .toStringAsFixed(2)),
            'giờ',
            true),
        _buildAttendanceInvalid(
            'Số giờ làm dư thừa',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.redundant!)
                .toStringAsFixed(2)),
            'giờ',
            false),
        _buildAttendanceInvalid(
            'Số giờ tăng ca',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.overtime!)
                .toStringAsFixed(2)),
            'giờ',
            false),
        _buildAttendanceInvalid(
            'Vắng',
            listAttendanceModel.fold(
                0.0, (prev, e) => prev + (e.isAbsent == true ? 1 : 0)),
            'ngày',
            false),
        _buildAttendanceInvalid('Công chuẩn', 27, 'ngày', false),
        _buildAttendanceInvalid(
            'Tổng công tính lương',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.workDay!)
                .toStringAsFixed(2)),
            'ngày',
            false),
        SizedBox(height: 20),
        _buildAttendanceInvalid(
            'Số giờ đi muộn',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.late!)
                .toStringAsFixed(2)),
            'giờ',
            true),
        _buildAttendanceInvalid(
            'Số giờ về sớm',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.soon!)
                .toStringAsFixed(2)),
            'giờ',
            true),
        _buildAttendanceInvalid(
            'Số giờ đi muộn/về sớm',
            double.parse(listAttendanceModel
                .fold(0.0, (prev, e) => prev + e.late! + e.soon!)
                .toStringAsFixed(2)),
            'giờ',
            false),
        SizedBox(height: 20),
        _buildAttendanceInvalid(
            'Số lần quên checkin/checkout',
            listAttendanceModel.fold(0.0, (prev, e) => prev + e.noScan!),
            'lần',
            true),
      ],
    ),
  );
}

Widget _buildAttendanceInvalid(
    String label, double nAttendanceInvalid, String unit, bool more) {
  return Container(
    color: Colors.white,
    margin: const EdgeInsets.only(left: 10, right: 10, top: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              TextStyle(color: blueBlack, fontFamily: 'roboto', fontSize: 16),
        ),
        const Expanded(child: SizedBox.shrink()),
        Text(
          '$nAttendanceInvalid $unit',
          style: const TextStyle(color: blueBlack),
        ),
        more
            ? const SizedBox(
                height: 30,
                width: 25,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
              )
            : const SizedBox(
                width: 10,
              ),
      ],
    ),
  );
}

Widget _buildOffset(int nOffset) {
  return Container(
    color: Colors.white,
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Số phiếu bù công',
          style:
              TextStyle(color: blueBlack, fontFamily: 'roboto', fontSize: 16),
        ),
        Text(
          '$nOffset phiếu',
          style: const TextStyle(color: blueBlack),
        ),
      ],
    ),
  );
}

Widget _buildOnleave(int nOnLeave) {
  return Container(
    color: Colors.white,
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Số phiếu nghỉ phép',
          style:
              TextStyle(color: blueBlack, fontFamily: 'roboto', fontSize: 16),
        ),
        Text(
          '$nOnLeave phiếu',
          style: const TextStyle(color: blueBlack),
        ),
      ],
    ),
  );
}

Widget _buildTimeSheetsItem(TimeSheetModel timeSheetModel) {
  return Container(
    color: Colors.white,
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(timeSheetModel.title,
          style: const TextStyle(
              color: blueBlack, fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 10),
      Container(height: 1, color: Colors.grey[200], width: double.infinity),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ngày công thực tế',
            style:
                TextStyle(color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
          ),
          Text(
            '${timeSheetModel.totalDay} công',
            style: const TextStyle(color: blueBlack),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Giờ công thực tế',
            style:
                TextStyle(color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
          ),
          Text(
            '${timeSheetModel.totalHour} giờ',
            style: const TextStyle(color: blueBlack),
          ),
        ],
      )
    ]),
  );
}

String dateRange(DateTime? fromDate, DateTime? toDate) {
  if (fromDate == null || toDate == null) {
    return 'Chọn ngày';
  }
  return '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
}
