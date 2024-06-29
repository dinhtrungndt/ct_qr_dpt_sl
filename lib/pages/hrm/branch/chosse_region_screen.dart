import 'package:flutter/material.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';

class ChooseRegionScreen extends StatelessWidget {
  const ChooseRegionScreen({Key? key, required this.regionList})
      : super(key: key);
  final List<RegionModel> regionList;
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
            itemCount: regionList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChooseItem(context, regionList[index]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }
}

Widget buildChooseItem(BuildContext context, RegionModel model) {
  return InkWell(
    onTap: () {
      Navigator.pop(context, model);
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
