import 'package:erp/base/widget/loading.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/account/bloc/account_bloc.dart';
import 'package:erp/widget/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime birthDayChange = DateTime.now();

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late AccountBloc accountBloc = BlocProvider.of<AccountBloc>(context);
    accountBloc.add(InitialAccountEvent());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context)!.editProfile,
            style: const TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 1,
          actions: [
            InkWell(
              child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context)!.save,
                      style: const TextStyle(color: blueBlack))),
              onTap: () {
                if (fullNameController.text.trim() == '') {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return closeDialog(context, 'Thông báo',
                            'Vui lòng điền đầy đủ thông tin');
                      });
                  return;
                }
                BlocProvider.of<AccountBloc>(context).add(SendAccountEvent(
                    fullName: fullNameController.text,
                    address: addressController.text,
                    phone: phoneController.text));
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          bloc: accountBloc,
          builder: (context, state) {
            if (state.fullName != null) {
              fullNameController.text = state.fullName ?? "";
              addressController.text = state.address ?? "";
              phoneController.text = state.phone ?? "";
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildInfo(),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.information,
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.fullName),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Nguyen Van A',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.birthDay),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .select,
                                                        style: const TextStyle(
                                                            fontSize: 20)),
                                                    SizedBox(
                                                      height: 200,
                                                      child:
                                                          CupertinoDatePicker(
                                                        onDateTimeChanged:
                                                            (value) {
                                                          birthDayChange =
                                                              value;
                                                        },
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 50,
                                                            child:
                                                                OutlinedButton(
                                                                    style: OutlinedButton
                                                                        .styleFrom(
                                                                      // primary: mainColor,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      side: const BorderSide(
                                                                          color:
                                                                              mainColor,
                                                                          width:
                                                                              1),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                        AppLocalizations.of(context)!
                                                                            .cancel,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            color:
                                                                                mainColor)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    }),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 50,
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    elevation: 0.0,
                                                                    shadowColor: Colors.transparent,
                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                    // primary: mainColor,
                                                                    backgroundColor: mainColor),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  accountBloc.add(
                                                                      ChangeBirthDayEvent(
                                                                          birthDayChange));
                                                                },
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .done,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .white),
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
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: backgroundColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(state.birthDay == null
                                            ? ''
                                            : DateFormat('dd/MM/yyyy')
                                                .format(state.birthDay!))),
                                  ),
                                ],
                              )),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!.gender),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                  child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () => {
                                                      accountBloc.add(
                                                          ChangeGenderEvent(
                                                              true)),
                                                      Navigator.pop(context),
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .male,
                                                        style: const TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => {
                                                      accountBloc.add(
                                                          ChangeGenderEvent(
                                                              false)),
                                                      Navigator.pop(context),
                                                    },
                                                    child: ListTile(
                                                      title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .female,
                                                        style: const TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: ListTile(
                                                      title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .cancel,
                                                        style: const TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: backgroundColor
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 50,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.gender == true
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .male
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .female,
                                                style: const TextStyle(
                                                    color: blueBlack),
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: blueGrey1,
                                              )
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!.code),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: backgroundColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 50,
                                        width: double.infinity,
                                        child: TextFormField(
                                            enabled: false,
                                            initialValue: state.code)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!
                                        .attendCode),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: backgroundColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 50,
                                        width: double.infinity,
                                        child: TextFormField(
                                            enabled: false,
                                            initialValue: state.attendCode)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.address),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                controller: addressController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!.phone),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(10),
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     AppLocalizations.of(context)!.companyProfile,
                    //     style: TextStyle(
                    //         color: blueBlack.withOpacity(0.7), fontSize: 18),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(AppLocalizations.of(context)!.department),
                    //         ],
                    //       ),
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             color: backgroundColor.withOpacity(0.2),
                    //             borderRadius: BorderRadius.circular(5)),
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         height: 50,
                    //         width: double.infinity,
                    //         child: Center(
                    //           child: TextFormField(
                    //             keyboardType: TextInputType.number,
                    //             decoration: const InputDecoration(
                    //               contentPadding: EdgeInsets.zero,
                    //               hintStyle: TextStyle(color: Colors.grey),
                    //               border: InputBorder.none,
                    //             ),
                    //             initialValue: state.organization,
                    //             enabled: false,
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(height: 10),
                    //       Row(
                    //         children: [
                    //           Text(AppLocalizations.of(context)!.position),
                    //         ],
                    //       ),
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             color: backgroundColor.withOpacity(0.2),
                    //             borderRadius: BorderRadius.circular(5)),
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         height: 50,
                    //         width: double.infinity,
                    //         child: Center(
                    //           child: TextFormField(
                    //             keyboardType: TextInputType.number,
                    //             decoration: const InputDecoration(
                    //               contentPadding: EdgeInsets.zero,
                    //               hintStyle: TextStyle(color: Colors.grey),
                    //               border: InputBorder.none,
                    //             ),
                    //             initialValue: state.position,
                    //             enabled: false,
                    //           ),
                    //         ),
                    //       ),
                    //       // const SizedBox(height: 10),
                    //       // Row(
                    //       //   children: [
                    //       //     Text(AppLocalizations.of(context)!.salary)
                    //       //   ],
                    //       // ),
                    //       // Container(
                    //       //   decoration: BoxDecoration(
                    //       //       color: backgroundColor.withOpacity(0.2),
                    //       //       borderRadius: BorderRadius.circular(5)),
                    //       //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //       //   height: 50,
                    //       //   width: double.infinity,
                    //       //   child: Center(
                    //       //     child: TextFormField(
                    //       //       keyboardType: TextInputType.number,
                    //       //       decoration: const InputDecoration(
                    //       //         contentPadding: EdgeInsets.zero,
                    //       //         hintStyle: TextStyle(color: Colors.grey),
                    //       //         border: InputBorder.none,
                    //       //       ),
                    //       //       initialValue: state.salary.toString(),
                    //       //       enabled: false,
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //       const SizedBox(height: 20),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              );
            } else {
              return const Loading();
            }
          },
        ));
  }
}

Widget _buildInfo() {
  return Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(25)),
          child: Center(
              child: Text(
            acronymName(User.name),
            style: const TextStyle(fontSize: 40, color: Colors.white),
          )),
        ),
        // Positioned(
        //     bottom: -5,
        //     right: -5,
        //     child: Container(
        //       width: 30,
        //       height: 30,
        //       decoration: BoxDecoration(
        //         border: Border.all(width: 2, color: Colors.white),
        //         shape: BoxShape.circle,
        //         color: const Color.fromRGBO(130, 139, 163, 1),
        //       ),
        //       child: const Icon(
        //         Icons.camera_alt_outlined,
        //         color: Colors.white,
        //         size: 20,
        //       ),
        //     ))
      ],
    ),
  );
}
