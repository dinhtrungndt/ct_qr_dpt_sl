import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/attendance_model.dart';
import '../../../config/color.dart';
import 'bloc/salary_calculate_bloc.dart';

class ChooseSalaryPeriodCalculateScreen extends StatelessWidget {
  const ChooseSalaryPeriodCalculateScreen(
      {Key? key, required this.listSalaryPeriodModel})
      : super(key: key);
  final List<SalaryPeriodModel> listSalaryPeriodModel;

  @override
  Widget build(BuildContext context) {
    // TimekeepingOffsetController controller =
    //     Get.find<TimekeepingOffsetController>();
    // controller.checkListShiftModel();
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: listSalaryPeriodModel.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildChooseItem(
                  context, index, listSalaryPeriodModel[index], (int id) {
                BlocProvider.of<SalaryCalculateBloc>(context).add(
                    ChooseSalaryPeriod(
                        salaryPeriod: listSalaryPeriodModel[id]));
              });
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget _buildChooseItem(BuildContext context, int id, SalaryPeriodModel model,
    Function(int) selected) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      selected(id);
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        //capitalize(name),
        //'Tháng ${model.month}, ${model.fromDate.year}',
        'Tháng ${model.month} - ${model.year} (Kỳ ${model.termInAMonth == 1 ? 'lương ứng' : 'lương chính'})',
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
