import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/branch/branch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import 'bloc/branch_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditBranchScreen extends StatelessWidget {
  const EditBranchScreen(
      {super.key, required this.branchModel, required this.areaName});
  final BranchModel branchModel;
  final String areaName;
  @override
  Widget build(BuildContext context) {
    TextEditingController branchController =
        TextEditingController(text: branchModel.name);
    TextEditingController noteController =
        TextEditingController(text: branchModel.description);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: Text(AppLocalizations.of(context)!.branch,
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
              BlocProvider.of<BranchBloc>(context).add(AddBranchEvent(
                  id: branchModel.id,
                  areaID: branchModel.areaID,
                  site: UserModel.siteName,
                  name: branchController.text,
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
              Text(AppLocalizations.of(context)!.area,
                  style: const TextStyle(color: blueGrey1)),
              const Text(' *', style: TextStyle(color: Colors.red))
            ],
          ),
          const SizedBox(height: 10),
          Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    areaName,
                    style: const TextStyle(color: blueBlack, fontSize: 16),
                  )),
                  const Icon(Icons.arrow_forward_ios,
                      color: blueGrey1, size: 22)
                ],
              )),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(AppLocalizations.of(context)!.branch,
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
              controller: branchController,
              cursorColor: backgroundColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
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
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
                hintText: AppLocalizations.of(context)!.enterText,
                hintStyle: const TextStyle(color: blueGrey2),
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
                    BlocProvider.of<BranchBloc>(context)
                        .add(DeleteBranchEvent(id: branchModel.id));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BranchListScreen()));
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
