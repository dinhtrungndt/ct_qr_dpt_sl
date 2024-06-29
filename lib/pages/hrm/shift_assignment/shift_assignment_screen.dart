import 'package:erp/base/widget/loading.dart';
import 'package:erp/model/hrm_model/work_plan_model.dart';
import 'package:erp/pages/hrm/shift_assignment/assign_screen.dart';
import 'package:erp/pages/hrm/shift_assignment/bloc/shift_assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../../model/hrm_model/shift_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../shift/edit_shift_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdministrativeShift {
  final DateTime date;
  final List<String> personnelList;
  AdministrativeShift({required this.date, required this.personnelList});
}

class ShiftAssignmentScreen extends StatefulWidget {
  const ShiftAssignmentScreen({super.key});

  @override
  State<ShiftAssignmentScreen> createState() => _ShiftAssignmentScreenState();
}

class _ShiftAssignmentScreenState extends State<ShiftAssignmentScreen> {
  late ShiftAssignmentBloc shiftAssignmentBloc;

  @override
  void initState() {
    shiftAssignmentBloc = BlocProvider.of<ShiftAssignmentBloc>(context);
    shiftAssignmentBloc.add(ShiftAssignmentInitialEvent());
    super.initState();
  }

  int filterKind = 2;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocListener<ShiftAssignmentBloc, ShiftAssignmentState>(
        listener: (context, state) {
          if (state.status == Status.saveSuccess) {
            EasyLoading.showSuccess('Save success');
            Navigator.pop(context);
          } else if (state.status == Status.failure) {
            EasyLoading.showSuccess('Something is wrong');
          } else if (state.status == Status.deleteSuccess) {
            EasyLoading.showSuccess('Delete success');
          }
        },
        child: BlocBuilder<ShiftAssignmentBloc, ShiftAssignmentState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: blueBlack),
                  elevation: 0,
                  centerTitle: true,
                  title: InkWell(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.arrangeShift,
                          style: const TextStyle(color: blueBlack),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    color: Colors.white,
                    child: Column(children: [
                      buildCurrentWeek(context, state.day, () {
                        shiftAssignmentBloc.add(ChangeWeekEvent(number: 1));
                      }, () {
                        shiftAssignmentBloc.add(ChangeWeekEvent(number: -1));
                      }),
                      const SizedBox(height: 15),
                      buildFirstDayOfWeek(context, state.first),
                      const SizedBox(height: 15),
                      buildLastDayOfWeek(context, state.last),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  // buildTab(1),
                  state.status == Status.loading
                      ? const Loading()
                      : Expanded(
                          child: SingleChildScrollView(
                          child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: 7,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return buildWorkPlan(
                                    state.listWorkPlanModel,
                                    state.first,
                                    context,
                                    index,
                                    shiftAssignmentBloc);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(
                                          height: 1, color: Colors.grey[200])),
                        )),
                  const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 1),
                  //   child: ListView.separated(
                  //       padding: const EdgeInsets.all(8),
                  //       shrinkWrap: true,
                  //       itemCount: 4,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return buildWorkPlan(state.listWorkPlanModel,
                  //             state.first, context, index);
                  //       },
                  //       separatorBuilder: (BuildContext context, int index) =>
                  //           Container(height: 1, color: Colors.grey[200])),
                  // ),
                ])

                //  Column(
                //     children: [
                //       buildDay(),
                //       const SizedBox(height: 20),
                //       Container(
                //         height: 1,
                //         width: double.infinity,
                //         color: Colors.grey[200],
                //       ),
                //       const SizedBox(height: 5),
                //       Container(
                //         height: 40,
                //         width: 150,
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 30, vertical: 5),
                //         decoration: BoxDecoration(
                //             color: Colors.grey[200],
                //             borderRadius: BorderRadius.circular(20)),
                //         child: const Center(child: Text('Giám đốc')),
                //       ),
                //       const SizedBox(height: 5),
                //       buildListShift(width)
                //     ],
                //   )
                );
          },
        ),
      ),
    );
  }

  Widget buildModalBottomSort(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 3, width: 50, color: Colors.grey),
            const SizedBox(height: 10),
            const Text('Chọn loại', style: TextStyle(fontSize: 20)),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sắp xếp theo phòng ban',
                        style: TextStyle(fontSize: 17, color: blueGrey1)),
                    Icon(
                      Icons.check,
                      color: filterKind == 1 ? mainColor : Colors.white,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sắp xếp theo nhân viên',
                      style: TextStyle(fontSize: 17, color: blueGrey1),
                    ),
                    Icon(
                      Icons.check,
                      color: filterKind == 2 ? mainColor : Colors.white,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trùng lặp',
                      style: TextStyle(fontSize: 17, color: blueGrey1),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBranch(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Chi nhánh:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        name,
        style: const TextStyle(color: mainColor),
      )
    ],
  );
}

Widget buildCurrentWeek(BuildContext context, DateTime? day,
    VoidCallback onPressPrev, VoidCallback onPressNext) {
  int numberWeek = day != null ? weeksOfYear(day) : 0;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(AppLocalizations.of(context)!.currentWeek,
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Row(
        children: [
          InkWell(
            onTap: onPressPrev,
            child: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: blueGrey1,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            day == null ? '' : 'T$numberWeek-${day.year}',
            style: const TextStyle(color: mainColor),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: onPressNext,
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: blueGrey1,
            ),
          ),
        ],
      )
    ],
  );
}

Widget buildFirstDayOfWeek(BuildContext context, DateTime? day) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(AppLocalizations.of(context)!.firstDayOfWeek,
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        DateFormat('dd/MM/yyyy').format(day ?? DateTime.now()),
        style: const TextStyle(color: mainColor),
      )
    ],
  );
}

Widget buildLastDayOfWeek(BuildContext context, DateTime? day) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(AppLocalizations.of(context)!.lastDayOfWeek,
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        DateFormat('dd/MM/yyyy').format(day ?? DateTime.now()),
        style: const TextStyle(color: mainColor),
      )
    ],
  );
}

// Widget buildTab(int curentTab) {
//   return Container(
//     width: double.infinity,
//     color: Colors.white,
//     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//     child: Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(20),
//           decoration: (curentTab == 1)
//               ? BoxDecoration(
//                   color: mainColor.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: mainColor))
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: const Color(0xFFF3F6FF)),
//           child: const Column(
//               children: [Text('Ca hành chính'), Text('08:00-17:30')]),
//         ),
//         const SizedBox(width: 10),
//         Container(
//           padding: const EdgeInsets.all(20),
//           decoration: (curentTab == 2)
//               ? BoxDecoration(
//                   color: mainColor.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: mainColor))
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: const Color(0xFFF3F6FF)),
//           child: const Column(
//               children: [Text('Ca chủ nhật'), Text('08:00-12:00')]),
//         ),
//         const Expanded(
//           child: SizedBox.shrink(),
//         ),
//         const Icon(
//           Icons.edit_outlined,
//           color: Color(0xFF1BCA75),
//         )
//       ],
//     ),
//   );
// }

Widget buildWorkPlan(List<WorkPlanModel> listWorkPlanModel, DateTime? first,
    BuildContext context, int index, ShiftAssignmentBloc saBloc) {
  DateTime date =
      first != null ? first.add(Duration(days: index)) : DateTime.now();
  List<WorkPlanModel> listWorkPlan = listWorkPlanModel.where((element) {
    return element.day.year == date.year &&
        element.day.month == date.month &&
        element.day.day == date.day;
  }).toList();
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${DateFormat('EEEE', AppLocalizations.of(context)!.languageCode).format(date)}, ${DateFormat('dd/MM/yyyy').format(date)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            InkWell(
              child: const Icon(
                Icons.add,
                color: mainColor,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssignScreen(date: date)));
              },
            )
          ],
        ),
      ),
      for (int i = 0; i < listWorkPlan.length; i++)
        buildPersonnel(listWorkPlan[i].fullName, listWorkPlan[i].shiftID,
            listWorkPlan[i].shiftName, date, saBloc)
    ],
  );
}

Widget buildPersonnel(String name, int shiftID, String shift, DateTime date,
    ShiftAssignmentBloc saBloc) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xFFB3C0E0),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            acronymName(name),
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name),
            const SizedBox(height: 5),
            Text(
              shift,
              style: const TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ],
        )),
        InkWell(
          child: const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 22,
          ),
          onTap: () {
            saBloc.add(DeleteWorkPlanEvent(dateApply: date, shiftID: shiftID));
          },
        )
      ],
    ),
  );
}

List<AdministrativeShift> getData(DateTime date) {
  List<AdministrativeShift> list = [];
  DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
  for (int i = 0; i < 6; i++) {
    list.add(AdministrativeShift(
        date: firstDayOfWeek.add(Duration(days: i)),
        personnelList: ['trung nguyen', 'Nhan vien Demo']));
  }
  return list;
}

Widget buildDay() {
  DateTime now = DateTime.now();
  int day = now.day;
  int firstDayOfWeek = now.weekday;
  DateFormat('EEEE').format(now);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      for (int i = 0; i < 7; i++)
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    getDay(i + 1),
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: Text(
                        now
                            .subtract(Duration(days: firstDayOfWeek - 1 - i))
                            .day
                            .toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: (now
                                        .subtract(Duration(
                                            days: firstDayOfWeek - 1 - i))
                                        .day !=
                                    day)
                                ? Colors.black
                                : mainColor),
                      ),
                    ),
                  )
                ]),
          ),
        )
    ],
  );
}

Widget buildListShift(double w) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 1, false),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 2, false),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(1),
                w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem('trung nguyen', WorkShiftModel.getWorkShiftModel(2),
                w, 7, false),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 1, false),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 2, false),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(2), w, 7, false),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 1, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 2, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(1), w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem('Nhan vien demo',
                WorkShiftModel.getWorkShiftModel(2), w, 7, true),
          ],
        )
      ],
    ),
  );
}

Widget buildShiftItem(
    String name, WorkShiftModel sm, double w, int d, bool empty) {
  int dayOfWeek = DateTime.now().weekday;
  return Expanded(
    child: InkWell(
        onTap: () {
          if (!empty) {
            // Get.to(() => ShiftInformationScreen(
            //       date: DateTime.now(),
            //       edit: true,
            //     ));
          }
        },
        child: !empty
            ? Container(
                height: (w - 12) / 7 * 1.5,
                padding: const EdgeInsets.only(left: 5, top: 5),
                decoration: BoxDecoration(
                    color: dayOfWeek == d
                        ? backgroundColor.withOpacity(0.2)
                        : Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('08:00', style: TextStyle(fontSize: 12)),
                      Text(sm.id == 2 ? '12:00' : '17:30',
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 5),
                      Center(
                          child: Text(
                        name,
                        style: const TextStyle(fontSize: 8),
                      ))
                    ]))
            : Container(
                height: (w - 12) / 7 * 1.5,
                padding: const EdgeInsets.only(left: 5, top: 5),
                decoration: BoxDecoration(
                    color: dayOfWeek == d
                        ? backgroundColor.withOpacity(0.2)
                        : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ))),
  );
}
