// ignore_for_file: use_build_context_synchronously

import 'package:erp/base/widget/empty_screen.dart';
import 'package:erp/pages/hrm/position/bloc/position_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PositionListScreen extends StatelessWidget {
  const PositionListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PositionBloc>(context).add(GetPositionEvent());
    return Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.position,
            style: const TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const NewBranchScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<PositionBloc, PositionState>(
          builder: (context, state) {
            if (state is PositionWaiting) {
              return const Center(
                  child: CircularProgressIndicator(color: mainColor));
            }
            if (state is PositionSuccess) {
              return state.positionList.isEmpty
                  ? const EmptyScreen()
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                              itemCount: state.positionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    // List<RegionModel> regionList =
                                    //     await ApiProvider().getRegion(
                                    //         UserModel.siteName, User.token);
                                    // RegionModel region = regionList.firstWhere(
                                    //     (element) =>
                                    //         element.id ==
                                    //         state.PositionList[index].areaID);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           EditBranchScreen(
                                    //               branchModel:
                                    //                   state.PositionList[index],
                                    //               areaName: region.name)),
                                    // );
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
                                            state.positionList[index].name,
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
