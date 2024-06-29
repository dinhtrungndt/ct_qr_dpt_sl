import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import 'bloc/branch_bloc.dart';
import 'chosse_region_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewBranchScreen extends StatefulWidget {
  const NewBranchScreen({super.key});
  @override
  State<NewBranchScreen> createState() => _NewBranchScreenState();
}

class _NewBranchScreenState extends State<NewBranchScreen> {
  TextEditingController branchController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RegionModel? regionModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text(AppLocalizations.of(context)!.create,
                  style: const TextStyle(color: mainColor)),
            ),
            onTap: () {
              if (branchController.text.isEmpty || regionModel == null) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              BlocProvider.of<BranchBloc>(context).add(AddBranchEvent(
                  id: -1,
                  areaID: regionModel!.id,
                  site: UserModel.siteName,
                  name: branchController.text,
                  description: noteController.text));
              Navigator.pop(context);
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
                Text(AppLocalizations.of(context)!.area,
                    style: const TextStyle(color: blueGrey1)),
                const Text(' *', style: TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                List<RegionModel> regionList = await ApiProvider().getRegion();
                if (!mounted) return;
                dynamic result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChooseRegionScreen(regionList: regionList)));
                if (result != null) {
                  regionModel = result;
                  setState(() {});
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: (regionModel == null)
                            ? Text(
                                AppLocalizations.of(context)!.area,
                                style: const TextStyle(
                                    color: blueGrey2, fontSize: 16),
                              )
                            : Text(
                                regionModel!.name,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                              ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: blueGrey1, size: 22)
                    ],
                  )),
            ),
            const SizedBox(height: 20),
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
                controller: branchController,
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
