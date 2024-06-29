import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/overtime/bloc/overtime_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';

class OvertimeScreen extends StatefulWidget {
  const OvertimeScreen({super.key});

  @override
  State<OvertimeScreen> createState() => _OvertimeScreenState();
}

class _OvertimeScreenState extends State<OvertimeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocListener<OvertimeBloc, OvertimeState>(
          listener: (context, state) {},
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: blueBlack),
              elevation: 0,
              title: const Text('Tăng ca', style: TextStyle(color: blueBlack)),
              actions: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: const Text('TẠO',
                        style: TextStyle(color: mainColor, fontSize: 16)),
                  ),
                  onTap: () {},
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<OvertimeBloc, OvertimeState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Mã quyết định',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF3F6FF),
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            child: TextFormField(
                              cursorColor: blueBlack,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 16),
                              maxLines: 5,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                hintStyle:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text('Tên quyết định',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF3F6FF),
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            child: TextFormField(
                              cursorColor: blueBlack,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 16),
                              maxLines: 5,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                hintStyle:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text('Ca tăng',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ChooseOnLeaveKindScreen(
                              //               listOnLeaveKindModel: state
                              //                   .listOnLeaveKindModel,
                              //             )));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Entypo.layout,
                                      color: blueGrey2,
                                      size: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: null == null
                                          ? const Text(
                                              'Chọn ca tăng ca',
                                              style: TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16),
                                            )
                                          : Text(
                                              '',
                                              style: const TextStyle(
                                                  color: blueBlack,
                                                  fontSize: 16),
                                            ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: blueGrey1,
                                      size: 30,
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(height: 15),
                          const Text('Ngày áp dụng',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 10),
                                            const Text('Chọn',
                                                style: TextStyle(fontSize: 20)),
                                            SizedBox(
                                              height: 200,
                                              // child: CupertinoDatePicker(
                                              //   initialDateTime:
                                              //       (state.expirationDate ==
                                              //               null)
                                              //           ? DateTime.now()
                                              //           : state
                                              //               .expirationDate,
                                              //   onDateTimeChanged:
                                              //       (value) {
                                              //     expirationDateChange =
                                              //         value;
                                              //   },
                                              //   mode:
                                              //       CupertinoDatePickerMode
                                              //           .date,
                                              // ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          side:
                                                              const BorderSide(
                                                                  color:
                                                                      mainColor,
                                                                  width: 1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        child: const Text('HỦY',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                color:
                                                                    mainColor)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 50,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            elevation: 0.0,
                                                            shadowColor: Colors
                                                                .transparent,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            backgroundColor:
                                                                mainColor),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          // onLeaveBloc.add(
                                                          //     ChooseExpirationDateEvent(
                                                          //         expirationDate:
                                                          //             expirationDateChange));
                                                        },
                                                        child: const Text(
                                                          "XONG",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ));
                                  });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Icon(Icons.date_range,
                                        color: blueGrey2),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: const Text(
                                        'Chọn ngày áp dụng',
                                        style: TextStyle(
                                            color: blueGrey2, fontSize: 16),
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: blueGrey1, size: 30)
                                  ],
                                )),
                          ),
                          const SizedBox(height: 15),
                          const Text('Lý do tăng ca',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ChooseOnLeaveKindScreen(
                              //               listOnLeaveKindModel: state
                              //                   .listOnLeaveKindModel,
                              //             )));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Entypo.layout,
                                      color: blueGrey2,
                                      size: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: null == null
                                          ? const Text(
                                              'Chọn lý do',
                                              style: TextStyle(
                                                  color: blueGrey2,
                                                  fontSize: 16),
                                            )
                                          : Text(
                                              '',
                                              style: const TextStyle(
                                                  color: blueBlack,
                                                  fontSize: 16),
                                            ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: blueGrey1,
                                      size: 30,
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(height: 15),
                          const Text('Ghi chú',
                              style: TextStyle(color: blueGrey1)),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF3F6FF),
                                borderRadius: BorderRadius.circular(5)),
                            height: 100,
                            child: TextFormField(
                              cursorColor: blueBlack,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 16),
                              maxLines: 5,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 5),
                                hintText: '',
                                hintStyle:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [],
                            ),
                          ),
                        ]),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
