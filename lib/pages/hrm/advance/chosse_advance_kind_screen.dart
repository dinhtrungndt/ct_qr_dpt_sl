import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/advance_model.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import 'bloc/advance_bloc.dart';

class ChooseAdvanceKindScreen extends StatelessWidget {
  const ChooseAdvanceKindScreen({Key? key, required this.listAdvanceKindModel})
      : super(key: key);
  final List<AdvanceKindModel> listAdvanceKindModel;
  @override
  Widget build(BuildContext context) {
    //NewOnleaveController controller = Get.find<NewOnleaveController>();
    //controller.checkListOnLeaveKindModel();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: blueBlack),
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
            itemCount: listAdvanceKindModel.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChooseItem(
                  context, index, listAdvanceKindModel[index].name, (int id) {
                BlocProvider.of<AdvanceBloc>(context).add(
                    ChooseAdvanceKindEvent(
                        advanceKind: listAdvanceKindModel[id]));
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
