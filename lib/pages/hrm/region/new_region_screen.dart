import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../widget/dialog.dart';
import 'bloc/region_bloc.dart';

class NewRegionScreen extends StatelessWidget {
  const NewRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController regionController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: Text(AppLocalizations.of(context)!.area,
            style: const TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.create,
                  style: const TextStyle(color: mainColor)),
            ),
            onTap: () {
              if (regionController.text.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              BlocProvider.of<RegionBloc>(context).add(AddRegionEvent(
                  id: -1,
                  name: regionController.text,
                  description: noteController.text));
              //addRegion(regionController.text, noteController.text);
              Navigator.pop(context);
              //BlocProvider.of<RegionBloc>(context).add(GetRegionEvent(site: EmployeeModel.siteName, token: User.token));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.name,
                    style: const TextStyle(color: blueGrey1)),
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
                controller: regionController,
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: AppLocalizations.of(context)!.enterText,
                  hintStyle: const TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.note,
                style: const TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 150,
              width: double.infinity,
              child: TextFormField(
                controller: noteController,
                cursorColor: backgroundColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: AppLocalizations.of(context)!.enterText,
                  hintStyle: const TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

addRegion(String name, String note) {
  // List<RegionModel> regionList = CompanyModel.regionList;
  // int id = regionList.isEmpty ? 1 : regionList.last.id + 1;
  // CompanyModel.regionList
  //     .add(RegionModel(id: id, name: name, note: note, branchList: []));
}
