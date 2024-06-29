import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import '../check_in_out.dart/bloc/check_in_out_bloc.dart';

class ChooseLocationScreen extends StatelessWidget {
  const ChooseLocationScreen({
    super.key,
    required this.locationList,
  });
  final List<LocationModel> locationList;
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: locationList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChooseItem(context, locationList[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget buildChooseItem(BuildContext context, LocationModel model) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      BlocProvider.of<CheckInOutBloc>(context)
          .add(ChooseLocationEvent(location: model));
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        model.name,
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
