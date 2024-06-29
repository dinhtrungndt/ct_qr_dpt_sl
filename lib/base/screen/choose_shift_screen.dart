import 'package:erp/pages/hrm/shift_assignment/bloc/shift_assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/hrm_model/shift_model.dart';
import '../../config/color.dart';
import '../../method/hrm_method.dart';
import '../../pages/hrm/check_in_out.dart/bloc/check_in_out_bloc.dart';
import '../../pages/hrm/timekeeping_offset/bloc/timekeeping_offset_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseShiftScreen extends StatelessWidget {
  final List<ShiftModel> listShiftModel;
  final String screen;
  const ChooseShiftScreen(
      {Key? key, required this.listShiftModel, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.select,
          style: const TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: listShiftModel.length,
            itemBuilder: (BuildContext context, int index) {
              if (screen == 'check_in_out') {
                return _buildChooseItem(
                    context, index, listShiftModel[index].title, (int id) {
                  BlocProvider.of<CheckInOutBloc>(context)
                      .add(ChooseShiftEvent(shiftModel: listShiftModel[id]));
                });
              } else if (screen == 'shift_assignment') {
                return _buildChooseItem(
                    context, index, listShiftModel[index].title, (int id) {
                  BlocProvider.of<ShiftAssignmentBloc>(context).add(
                      ChooseShiftAssignmentEvent(
                          shiftModel: listShiftModel[id]));
                });
              } else if (screen == 'timekeeping_offset') {
                return _buildChooseItem(
                    context, index, listShiftModel[index].title, (int id) {
                  BlocProvider.of<TimekeepingOffsetBloc>(context).add(
                      ChooseTimekeepingOffsetShiftEvent(
                          shiftModel: listShiftModel[id]));
                });
              }
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget _buildChooseItem(
    BuildContext context, int id, String name, Function(int) selected) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      selected(id);
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        capitalize(name),
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
