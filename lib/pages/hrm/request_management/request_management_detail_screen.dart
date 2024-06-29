import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/on_leave/new_on_leave_screen.dart';
import 'package:erp/pages/hrm/timekeeping_offset/new_timekeeping_offset_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../model/hrm_model/request_management_model.dart';
import '../../../method/hrm_method.dart';
import 'bloc/request_management_bloc.dart';
import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestManagementDetailScreen extends StatefulWidget {
  String title = '';
  dynamic model;
  RequestManagementDetailScreen(
      {super.key, required this.title, required this.model});
  @override
  State<RequestManagementDetailScreen> createState() =>
      _RequestManagementDetailScreenState();
}

class _RequestManagementDetailScreenState
    extends State<RequestManagementDetailScreen> {
  late RequestManagementBloc requestManagementBloc;
  @override
  void initState() {
    requestManagementBloc = BlocProvider.of<RequestManagementBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        // actions: [
        //   InkWell(
        //       child: Container(
        //           margin: const EdgeInsets.all(5),
        //           child: const Icon(Icons.chat_bubble_outline_outlined)),
        //       onTap: () {}),
        //   InkWell(
        //       child: Container(
        //           margin: const EdgeInsets.all(5),
        //           child: const Icon(Icons.local_print_shop_outlined)),
        //       onTap: () {}),
        //   const SizedBox(
        //     width: 5,
        //   )
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 5,
                          height: 30,
                          color: getColor(widget.model.decision),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.title,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: getColor(widget.model.decision))),
                      child: Text(
                        getLabelStatus(widget.model.decision, context),
                        style:
                            TextStyle(color: getColor(widget.model.decision)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          acronymName(widget.model.fullName!),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.model.fullName!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(widget.model.createDate ?? DateTime.now())}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.department,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black45)),
                          Text(widget.model!.department,
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.position,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black45)),
                          Text(widget.model!.position,
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                widget.model is OnLeaveRequestModel
                    ? _buildOnLeaveDetail(widget.model, context)
                    : _buildTimekeepingDetail(widget.model, context),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  height: 70,
                  color: const Color.fromARGB(255, 200, 229, 234),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(widget.model.createBy!),
                            Text(
                              AppLocalizations.of(context)!.hadCreatedRequest,
                              style: const TextStyle(color: Colors.black38),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              DateFormat('MMMEd')
                                  .format(widget.model.createDate),
                              style: const TextStyle(color: Colors.black38),
                            )
                          ],
                        ),
                      ]),
                ),
                const SizedBox(height: 15),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.createQuestion),
                            const Spacer(),
                            // const Icon(
                            //   Icons.image_outlined,
                            //   color: Colors.black54,
                            // ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // const Icon(
                            //   Icons.photo_camera_outlined,
                            //   color: Colors.black54,
                            // ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            // const Icon(
                            //   Icons.attach_file_outlined,
                            //   color: Colors.black54,
                            // )
                          ],
                        ),
                      ),
                      ![3, 4].contains(widget.model.decision) &&
                              widget.model.employeeID == UserModel.id
                          ? Container(
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  widget.model.employeeID == UserModel.id
                                      ? Expanded(
                                          flex: 1,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              side: const BorderSide(
                                                  color: Colors.black38,
                                                  width: 1),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              handleEditRequest(
                                                  widget.model, context);
                                            },
                                            child: const Icon(Icons.edit,
                                                color: Colors.black38,
                                                size: 30),
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 4,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        side: const BorderSide(
                                            color: ASSENT_COLOR, width: 1),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<RequestManagementBloc>(
                                                context)
                                            .add(RequestManagementDeleteEvent(
                                                model: widget.model,
                                                context: context));
                                        Navigator.pop(context);
                                        BlocProvider.of<RequestManagementBloc>(
                                                context)
                                            .add(RequestManagementLoadEvent());
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.delete,
                                        style: const TextStyle(
                                            color: ASSENT_COLOR, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          )),
          widget.model.roleNo_ == ''
              ? Container()
              : Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.black12),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          side: const BorderSide(color: mainColor, width: 1),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            isScrollControlled: true,
                            context: context,
                            //useRootNavigator: false,
                            builder: (BuildContext context) {
                              return buildModalBottom(
                                  context,
                                  () => {
                                        requestManagementBloc.add(
                                            GiveDecisionDocType(
                                                docID: widget.model.id,
                                                status: 4,
                                                docType:
                                                    getDocType(widget.model))),
                                        Navigator.pop(context),
                                        BlocProvider.of<RequestManagementBloc>(
                                                context)
                                            .add(RequestManagementLoadEvent()),
                                      });
                            },
                          );
                        },
                        child: const Icon(
                          Icons.more_horiz,
                          color: mainColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 70, right: 70, top: 10, bottom: 10),
                          side: const BorderSide(color: mainColor, width: 1),
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          requestManagementBloc.add(GiveDecisionDocType(
                              docID: widget.model.id,
                              status: 3,
                              docType: getDocType(widget.model)));
                          Navigator.pop(context);
                          BlocProvider.of<RequestManagementBloc>(context)
                              .add(RequestManagementLoadEvent());
                        },
                        child: Text(AppLocalizations.of(context)!.approved,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

Widget _buildOnLeaveDetail(OnLeaveRequestModel model, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    color: Colors.white,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.day,
                    style: const TextStyle(color: Colors.black38),
                  ),
                  Text(
                    '${DateFormat('dd/MM').format(model.fromDate)} - ${DateFormat('dd/MM').format(model.toDate)}',
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.totalDay,
                style: const TextStyle(color: Colors.black38),
              ),
              Text(
                '${model.qty}',
              ),
            ],
          )
        ],
      ),
      const SizedBox(height: 25),
      Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.permissionType,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                Text(
                    capitalize(model.permissionName).replaceAll("", "\u{200B}"),
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.createdBy,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                Text(model.createBy! ?? 'admin',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.reason,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                const Text('Ốm', style: TextStyle(fontSize: 16))
              ],
            )
          ],
        ),
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          const Icon(
            Icons.people_outline,
            color: mainColor,
          ),
          const SizedBox(width: 10),
          Text(AppLocalizations.of(context)!.approvalInfo,
              style: const TextStyle(fontSize: 18, color: Colors.black45)),
        ],
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          Container(
            width: 3,
            height: 20,
            color: mainColor,
          ),
          const Text(' 1'),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              acronymName(User.name),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Tan Duong',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ]),
  );
}

Widget _buildTimekeepingDetail(
    TimekeepingOffsetRequestModel model, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    color: Colors.white,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.day,
                    style: const TextStyle(color: Colors.black38),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(model.dateApply),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.time,
                style: const TextStyle(color: Colors.black38),
              ),
              Text(
                '${DateFormat('HH:mm').format(model.fromTime)} - ${DateFormat('HH:mm').format(model.toTime)}'
                    .replaceAll("", "\u{200B}"),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.totalHour,
                style: const TextStyle(color: Colors.black38),
              ),
              const Text(
                '',
              ),
            ],
          )
        ],
      ),
      const SizedBox(height: 25),
      Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.createdBy,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                Text(model.createBy ?? '', style: const TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.shift,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                Text(model.shift, style: const TextStyle(fontSize: 16))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.reason,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black45)),
                Text(model.reason, style: const TextStyle(fontSize: 16))
              ],
            )
          ],
        ),
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          const Icon(
            Icons.people_outline,
            color: mainColor,
          ),
          const SizedBox(width: 10),
          Text(AppLocalizations.of(context)!.approvalInfo,
              style: const TextStyle(fontSize: 18, color: Colors.black45)),
        ],
      ),
      const SizedBox(height: 25),
      Row(
        children: [
          Container(
            width: 3,
            height: 20,
            color: mainColor,
          ),
          const Text(' 1'),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              acronymName(User.name),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Tan Duong',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ]),
  );
}

void handleEditRequest(dynamic model, BuildContext context) {
  if (model is TimekeepingOffsetRequestModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              NewTimekeepingOffsetScreen(timekeepingOffsetModel: model)),
    );
  } else if (model is OnLeaveRequestModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewOnLeaveScreen(onleaveRequestModel: model)),
    );
  }
}

Widget buildModalBottom(BuildContext context, VoidCallback func) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context)!.viewInsets.bottom),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 10, bottom: 10),
                    side: const BorderSide(color: ASSENT_COLOR, width: 1),
                    backgroundColor: ASSENT_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    func();
                  },
                  child: Text(AppLocalizations.of(context)!.rejected,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    side: const BorderSide(color: Colors.grey, width: 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: const TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Color getColor(int kind) {
  if (kind == 0) {
    return Colors.blue;
  } else if (kind == 3) {
    return mainColor;
  }
  return Colors.red;
}

String getLabelStatus(int kind, BuildContext context) {
  if (kind == 0) {
    return AppLocalizations.of(context)!.waiting;
  } else if (kind == 3) {
    return AppLocalizations.of(context)!.approved;
  }
  return AppLocalizations.of(context)!.rejected;
}

String getDocType(dynamic model) {
  if (model is TimekeepingOffsetRequestModel) {
    return "TKODocType";
  } else if (model is OnLeaveRequestModel) {
    return "OLDocType";
  }
  return "ADocType";
}
