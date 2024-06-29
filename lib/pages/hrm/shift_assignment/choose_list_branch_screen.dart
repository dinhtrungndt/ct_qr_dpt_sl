import 'package:flutter/material.dart';

import '../../../config/color.dart';
import '../../../model/hrm_model/company_model.dart';

class ChooseListBranchScreen extends StatefulWidget {
  const ChooseListBranchScreen({super.key, required this.branchList});
  final List<BranchModel> branchList;

  @override
  State<ChooseListBranchScreen> createState() => _ChooseListBranchScreenState();
}

class _ChooseListBranchScreenState extends State<ChooseListBranchScreen> {
  List choose = [];
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.branchList.length; i++) {
      choose.add(false);
    }
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
            itemCount: widget.branchList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChooseItem(context, widget.branchList[index], index);
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1, color: Colors.grey[200])),
      ),
    );
  }

  Widget buildChooseItem(BuildContext context, BranchModel model, int index) {
    return InkWell(
      onTap: () {
        choose[index] = !choose[index];
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text(
              model.name,
              style: const TextStyle(fontSize: 17, color: blueBlack),
            ),
          ),
          Visibility(
            visible: choose[index],
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
