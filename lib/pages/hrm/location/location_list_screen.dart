// ignore_for_file: use_build_context_synchronously

import 'package:erp/base/widget/empty_screen.dart';
import 'package:erp/model/hrm_model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import '../branch/bloc/branch_bloc.dart';
import 'bloc/location_bloc.dart';
import 'edit_location_screen.dart';
import 'new_location_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationListScreen extends StatelessWidget {
  const LocationListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocationBloc>(context).add(GetLocationEvent());
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationAddSuccess) {
          EasyLoading.showSuccess('Save success');
        } else if (state is LocationDeleteSuccess) {
          EasyLoading.showSuccess('Delete success');
          Navigator.pop(context);
        } else if (state is LocationFail) {
          EasyLoading.showError('Something is wrong');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.location,
            style: const TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewLocationScreen()),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationWaiting) {
              return const Center(
                  child: CircularProgressIndicator(color: mainColor));
            }
            if (state is LocationAddSuccess) {
              BlocProvider.of<LocationBloc>(context).add(GetLocationEvent());
            }
            if (state is LocationSuccess) {
              return state.locationList.isEmpty
                  ? const EmptyScreen()
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.locationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  List<BranchModel> regionList =
                                      await ApiProvider().getBranch();
                                  BranchModel branch = regionList.firstWhere(
                                      (element) =>
                                          element.id ==
                                          state.locationList[index].branchID);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditLocationScreen(
                                                locationModel:
                                                    state.locationList[index],
                                                branchName: branch.name)),
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
                                                state.locationList[index].name,
                                                style: const TextStyle(
                                                    color: blueBlack,
                                                    fontSize: 16))),
                                        const SizedBox(width: 20),
                                        const Icon(Icons.arrow_forward_ios,
                                            color: blueGrey1, size: 20)
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 2),
                          ),
                        ),
                      ],
                    );
            }
            return const EmptyScreen();
          },
        ),
      ),
    );
  }
}
