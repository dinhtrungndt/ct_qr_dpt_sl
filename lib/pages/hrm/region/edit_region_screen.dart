import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'region_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../widget/dialog.dart';
import 'bloc/region_bloc.dart';

class EditRegionScreen extends StatelessWidget {
  const EditRegionScreen({super.key, required this.regionModel});
  final RegionModel regionModel;
  @override
  Widget build(BuildContext context) {
    String regionName = regionModel.name;
    String note = regionModel.description;
    TextEditingController regionController =
        TextEditingController(text: regionName);
    TextEditingController noteController = TextEditingController(text: note);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Text(AppLocalizations.of(context)!.save,
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
                  id: regionModel.id,
                  name: regionController.text,
                  description: noteController.text));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(AppLocalizations.of(context)!.name,
                  style: const TextStyle(color: blueGrey1)),
              const Text(' *', style: TextStyle(color: Colors.red))
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
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.note,
              style: TextStyle(color: blueGrey1)),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 150,
            width: double.infinity,
            child: TextFormField(
              controller: noteController,
              cursorColor: backgroundColor,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.delete,
                      style: const TextStyle(fontSize: 18, color: Colors.red)),
                  onPressed: () {
                    BlocProvider.of<RegionBloc>(context)
                        .add(DeleteRegionEvent(id: regionModel.id));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegionListScreen()),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

editRegion(int id, String name, String note) {
  // List<RegionModel> regionList = CompanyModel.regionList;
  // for (int i = 0; i < regionList.length; i++) {
  //   if (regionList[i].id == id) {
  //     CompanyModel.regionList[i] =
  //         regionList[i].copyWith(name: name, note: nodete);
  //   }
  // }
}
