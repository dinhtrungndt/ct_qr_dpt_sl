import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/on_leave_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'bloc/on_leave_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseOnLeaveKindScreen extends StatelessWidget {
  const ChooseOnLeaveKindScreen({Key? key, required this.listOnLeaveKindModel})
      : super(key: key);
  final List<OnLeaveKindModel> listOnLeaveKindModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.permissionType,
          style: const TextStyle(color: blueBlack, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: listOnLeaveKindModel.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChooseItem(
                  context, index, listOnLeaveKindModel[index].name, (int id) {
                BlocProvider.of<OnLeaveBloc>(context).add(
                    ChooseOnLeaveKindEvent(
                        onLeaveKind: listOnLeaveKindModel[id]));
              });
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget buildChooseItem(
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