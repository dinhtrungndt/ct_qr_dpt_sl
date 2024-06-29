import 'package:erp/base/widget/empty_screen.dart';
import 'package:erp/pages/hrm/main_hrm_screen.dart';
import 'package:erp/pages/hrm/request_management/request_management_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/hrm_model/request_management_model.dart';
import '../../../method/hrm_method.dart';
import 'bloc/request_management_bloc.dart';
import 'choose_request_screen.dart';
import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestManagementScreen extends StatefulWidget {
  const RequestManagementScreen({super.key});

  @override
  State<RequestManagementScreen> createState() =>
      _RequestManagementScreenState();
}

class _RequestManagementScreenState extends State<RequestManagementScreen> {
  late RequestManagementBloc requestManagementBloc;
  @override
  void initState() {
    requestManagementBloc = BlocProvider.of<RequestManagementBloc>(context);
    requestManagementBloc.add(InitialRequestManagementEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainHRMScreen()),
                  ),
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.requestManagement,
            style: const TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          actions: [
            InkWell(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    child: const Icon(Icons.add)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseRequestScreen()));
                }),
            const SizedBox(width: 5),
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: BlocBuilder<RequestManagementBloc, RequestManagementState>(
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
                                                  requestManagementBloc.add(
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
                                                  requestManagementBloc.add(
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
                                                requestManagementBloc.add(
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
            Expanded(
              child: Container(
                child:
                    BlocBuilder<RequestManagementBloc, RequestManagementState>(
                  builder: (context, state) {
                    if (state.status == RequestManagementStatus.success) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildTabBar(
                              state.listRequestNew.length,
                              state.listRequestApprove.length,
                              state.listRequestReject.length,
                              context),
                          _buildTabarView(
                              state.listRequestNew,
                              state.listRequestApprove,
                              state.listRequestReject,
                              false)
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildTabBar(0, 0, 0, context),
                          _buildTabarView([], [], [], true)
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFromDayToDay(BuildContext context, DateTime fromDay,
    DateTime toDay, Function(PickerDateRange) changedDateRange) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 50),
    child: InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SfDateRangePicker(
                        headerStyle: const DateRangePickerHeaderStyle(
                            backgroundColor: Colors.blue,
                            textAlign: TextAlign.center,
                            textStyle:
                                TextStyle(fontSize: 22, color: Colors.white)),
                        headerHeight: 50,
                        view: DateRangePickerView.month,
                        showActionButtons: true,
                        selectionMode:
                            DateRangePickerSelectionMode.extendableRange,
                        onSubmit: (Object? value) {
                          Navigator.pop(context);
                          if (value == null) return;
                          changedDateRange(value as PickerDateRange);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
              style: const TextStyle(fontSize: 16, color: blueGrey1)),
          const Icon(Icons.arrow_drop_down, color: blueGrey1, size: 30)
        ],
      ),
    ),
  );
}

Widget _buildTabBar(int listNewLength, int listApproveLength,
    int listRejectLength, BuildContext context) {
  return SizedBox(
    height: 30,
    child: TabBar(
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: blueGrey3,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: [
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.request,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  padding: EdgeInsets.only(left: 2, right: 2),
                  decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listNewLength',
                    style: const TextStyle(color: Colors.blue),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.approved,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listApproveLength',
                    style: const TextStyle(color: mainColor),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.rejected,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  padding: EdgeInsets.only(left: 2, right: 2),
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listRejectLength',
                    style: const TextStyle(color: Colors.red),
                  )),
                )
              ],
            ),
          )),
        ]),
  );
}

Widget _buildTabarView(List<dynamic> listNew, List<dynamic> listApprove,
    List<dynamic> listReject, bool isLoading) {
  return Expanded(
      child: Container(
          color: mainColor.withOpacity(0.1),
          child: TabBarView(children: [
            LayoutBuilder(builder: (context, constraints) {
              if (listNew.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listNew.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listNew[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listNew[index], context);
                      } else if (listNew[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listNew[index], context);
                      } else {
                        return _buildAdvanceRequestItem(
                            listNew[index], context);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 15));
              } else {
                return const EmptyScreen();
              }
            }),
            LayoutBuilder(builder: (context, constraints) {
              if (listApprove.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listApprove.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listApprove[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listApprove[index], context);
                      } else if (listApprove[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listApprove[index], context);
                      } else {
                        return _buildAdvanceRequestItem(
                            listApprove[index], context);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 15));
              } else {
                return const EmptyScreen();
              }
            }),
            LayoutBuilder(builder: (context, constraints) {
              if (listReject.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listReject.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listReject[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listReject[index], context);
                      } else if (listReject[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listReject[index], context);
                      } else {
                        return _buildAdvanceRequestItem(
                            listReject[index], context);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 15));
              } else {
                return const EmptyScreen();
              }
            }),
          ])));
}

Widget _buildOnLeaveRequestItem(
    OnLeaveRequestModel model, BuildContext context) {
  return InkWell(
      onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RequestManagementDetailScreen(
                          title: AppLocalizations.of(context)!.onleave,
                          model: model,
                        )))
          },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            color: Colors.white,
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    acronymName(model.fullName!),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  model.fullName!,
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: getColor(model.decision))),
                  child: Text(
                    getLabelStatus(model.decision, context),
                    style: TextStyle(color: getColor(model.decision)),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: const Offset(
                    1.0, // Move to right 10  horizontally
                    .5, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Card(
              margin: const EdgeInsets.only(top: 50),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.onleave,
                              style: const TextStyle(
                                  color: blueBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17)),
                          Text(
                              model.createDate == null
                                  ? ''
                                  : DateFormat('dd/MM/yyyy')
                                      .format(model.createDate!),
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 12)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 1,
                      child: Container(
                          width: 4,
                          height: 40,
                          color: getColor(model.decision)),
                    )
                  ]),
                  const SizedBox(height: 10),
                  Container(
                      height: 1,
                      color: Colors.grey[200],
                      width: double.infinity),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.expiryDate,
                                  style: TextStyle(
                                      color: blueBlack.withOpacity(0.7),
                                      fontSize: 12)),
                              const SizedBox(height: 5),
                              Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(model.expired),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 13)),
                              const SizedBox(height: 10),
                              Text('${AppLocalizations.of(context)!.time} ',
                                  style: TextStyle(
                                      color: blueBlack.withOpacity(0.7),
                                      fontSize: 12)),
                              const SizedBox(height: 5),
                              Text(
                                  '${DateFormat('dd/MM/yyyy').format(model.fromDate)} - ${DateFormat('dd/MM/yyyy').format(model.toDate)}'
                                      .replaceAll("", "\u{200B}"),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.permissionType,
                                  style: TextStyle(
                                      color: blueBlack.withOpacity(0.7),
                                      fontSize: 12)),
                              const SizedBox(height: 5),
                              Text(
                                  capitalize(model.permissionName)
                                      .replaceAll("", "\u{200B}"),
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 13),
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 10),
                              Text(AppLocalizations.of(context)!.qty,
                                  style: TextStyle(
                                      color: blueBlack.withOpacity(0.7),
                                      fontSize: 12)),
                              const SizedBox(height: 5),
                              Text(model.qty.toString(),
                                  //overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ],
      ));
}

Widget _buildTimekeepingOffsetRequestItem(
    TimekeepingOffsetRequestModel model, BuildContext context) {
  return InkWell(
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RequestManagementDetailScreen(
                    title: AppLocalizations.of(context)!.timekeepingOffset,
                    model: model,
                  )))
    },
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          color: Colors.white,
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  acronymName(model.fullName!),
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                model.fullName!,
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 3, bottom: 3),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: getColor(model.decision))),
                child: Text(
                  getLabelStatus(model.decision, context),
                  style: TextStyle(color: getColor(model.decision)),
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 20.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: const Offset(
                  1.0, // Move to right 10  horizontally
                  .5, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Card(
            margin: const EdgeInsets.only(top: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.timekeepingOffset,
                            style: const TextStyle(
                                color: blueBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 17)),
                        Text(
                            model.createDate == null
                                ? ''
                                : DateFormat('dd/MM/yyyy')
                                    .format(model.createDate!),
                            style: const TextStyle(
                                color: blueBlack, fontSize: 12)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 1,
                    child: Container(
                        width: 4, height: 40, color: getColor(model.decision)),
                  )
                ]),
                const SizedBox(height: 10),
                Container(
                    height: 1, color: Colors.grey[200], width: double.infinity),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.day,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7),
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(model.dateApply),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 13)),
                            const SizedBox(height: 10),
                            Text(AppLocalizations.of(context)!.hour,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7),
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text(
                                '${DateFormat('HH:mm').format(model.fromTime)} - ${DateFormat('HH:mm').format(model.toTime)}'
                                    .replaceAll("", "\u{200B}"),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.shift,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7),
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text(model.shift,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 13),
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 10),
                            Text(AppLocalizations.of(context)!.reason,
                                style: TextStyle(
                                    color: blueBlack.withOpacity(0.7),
                                    fontSize: 12)),
                            const SizedBox(height: 5),
                            Text(model.reason,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAdvanceRequestItem(
    AdvanceRequestModel model, BuildContext context) {
  return InkWell(
    onTap: () => {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RequestManagementDetailScreen(
                    title: AppLocalizations.of(context)!.advance,
                    model: model,
                  )))
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(children: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.advance,
                      style: const TextStyle(
                          color: blueBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 17)),
                  Text(
                      model.createDate == null
                          ? ''
                          : DateFormat('dd/MM/yyyy').format(model.createDate!),
                      style: const TextStyle(color: blueBlack, fontSize: 12)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 1,
              child: Container(
                  width: 4, height: 40, color: getColor(model.status)),
            )
          ]),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.grey[200], width: double.infinity),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SỐ TIỀN',
                          style: TextStyle(
                              color: blueBlack.withOpacity(0.7), fontSize: 12)),
                      const SizedBox(height: 5),
                      Text(NumberFormat.decimalPattern('vi').format(model.qty),
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: blueBlack, fontSize: 13)),
                      const SizedBox(height: 10),
                      Text('HIỆU LỰC',
                          style: TextStyle(
                              color: blueBlack.withOpacity(0.7), fontSize: 12)),
                      const SizedBox(height: 5),
                      Text(
                          '${DateFormat('dd/MM/yyyy').format(model.effectFrom)} - ${DateFormat('dd/MM/yyyy').format(model.effectTo)}'
                              .replaceAll("", "\u{200B}"),
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: blueBlack, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOẠI TẠM ỨNG',
                          style: TextStyle(
                              color: blueBlack.withOpacity(0.7), fontSize: 12)),
                      const SizedBox(height: 5),
                      const Text('',
                          style: TextStyle(color: blueBlack, fontSize: 13),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Text('GHI CHÚ',
                          style: TextStyle(
                              color: blueBlack.withOpacity(0.7), fontSize: 12)),
                      const SizedBox(height: 5),
                      Text(model.description,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: blueBlack, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    ),
  );
}

Widget buildModalBottom(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context)!.viewInsets.bottom),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            child: Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        backgroundColor: mainColor),
                    child: const Text('Sửa',
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            child: Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        backgroundColor: Colors.black38),
                    child: const Text('Xóa',
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

String dateRange(DateTime? fromDate, DateTime? toDate) {
  if (fromDate == null || toDate == null) {
    return '';
  }
  return '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
}
