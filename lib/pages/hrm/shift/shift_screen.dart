import 'package:erp/base/widget/loading.dart';
import 'package:erp/config/color.dart';
import 'package:erp/method/hrm_method.dart';
import 'package:erp/model/hrm_model/shift_model.dart';
import 'package:erp/pages/hrm/shift/bloc/shift_bloc.dart';
import 'package:erp/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'edit_shift_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({Key? key}) : super(key: key);
  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  late ShiftBloc shiftBloc;

  @override
  void initState() {
    shiftBloc = BlocProvider.of<ShiftBloc>(context);
    shiftBloc.add(ShiftInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShiftBloc, ShiftState>(
      listener: (context, state) {
        if (state.sendStatus == ShiftStatus.lack) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return closeDialog(
                    context, 'Thông báo', 'Vui lòng điền đầy đủ thông tin');
              });
        } else if (state.sendStatus == ShiftStatus.failure) {
          EasyLoading.showError('Gửi yêu cầu thất bại');
        } else if (state.sendStatus == ShiftStatus.success) {
          Navigator.pop(context);
          EasyLoading.showSuccess('Gửi yêu cầu thành công');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.shift,
              style: const TextStyle(color: blueBlack)),
          actions: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context)!.create,
                    style: const TextStyle(color: mainColor, fontSize: 16)),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditShiftScreen()));
              },
            )
          ],
        ),
        body: BlocBuilder<ShiftBloc, ShiftState>(builder: (context, state) {
          return state.sendStatus == ShiftStatus.loading
              ? const Loading()
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                          itemCount: state.listShiftModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditShiftScreen(
                                          shiftModel:
                                              state.listShiftModel[index])),
                                );
                              },
                              child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height: 45,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        state.listShiftModel[index].title,
                                        style: const TextStyle(
                                            color: blueBlack, fontSize: 16),
                                      )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Icon(Icons.arrow_forward_ios,
                                          color: blueGrey1, size: 20)
                                    ],
                                  )),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 2)),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}

Widget buildShiftItem(String name, String time) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 15),
    height: 50,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        name,
        style: const TextStyle(fontSize: 16),
      ),
      Text(
        time,
        style: const TextStyle(fontSize: 16),
      ),
    ]),
  );
}

Widget _buildChooseItem(BuildContext context, ShiftModel shiftModel) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditShiftScreen(shiftModel: shiftModel)));
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        capitalize(shiftModel.title),
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
