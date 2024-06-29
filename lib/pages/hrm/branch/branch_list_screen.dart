// ignore_for_file: use_build_context_synchronously

import 'package:erp/base/widget/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import 'bloc/branch_bloc.dart';
import 'edit_branch_screen.dart';
import 'new_branch_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BranchBloc>(context)
        .add(GetBranchEvent(site: UserModel.siteName, token: User.token));
    return Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.branch,
            style: const TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewBranchScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<BranchBloc, BranchState>(
          builder: (context, state) {
            if (state is BranchWaiting) {
              return const Center(
                  child: CircularProgressIndicator(color: mainColor));
            }
            if (state is BranchAddSuccess) {
              BlocProvider.of<BranchBloc>(context).add(
                  GetBranchEvent(site: UserModel.siteName, token: User.token));
            }
            if (state is BranchSuccess) {
              return state.branchList.isEmpty
                  ? const EmptyScreen()
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                              itemCount: state.branchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    List<RegionModel> regionList =
                                        await ApiProvider().getRegion();

                                    RegionModel region = regionList.firstWhere(
                                        (element) =>
                                            element.id ==
                                            state.branchList[index].areaID);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditBranchScreen(
                                                  branchModel:
                                                      state.branchList[index],
                                                  areaName: region.name)),
                                    );
                                  },
                                  child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 45,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            state.branchList[index].name,
                                            style: const TextStyle(
                                                color: blueBlack, fontSize: 16),
                                          )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          const Icon(Icons.arrow_forward_ios,
                                              color: blueGrey1, size: 20)
                                        ],
                                      )),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 2)),
                        ),
                      ],
                    );
            }
            return const EmptyScreen();
          },
        ));
  }
}
