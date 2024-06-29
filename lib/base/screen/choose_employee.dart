import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/shift_assignment/bloc/shift_assignment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/color.dart';
import '../../method/hrm_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseEmployeeScreen extends StatelessWidget {
  final String screen;
  const ChooseEmployeeScreen({Key? key, required this.screen})
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _buildChooseItem(screen, context),
        ),
      ),
    );
  }
}

Widget _buildChooseItem(String screen, BuildContext context) {
  return InkWell(
    onTap: () {
      if (screen == 'shift_assignment') {
        BlocProvider.of<ShiftAssignmentBloc>(context)
            .add(ChooseEmployeeEvent(employeeID: UserModel.id));
      }
      Navigator.pop(context);
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        capitalize(User.name),
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
