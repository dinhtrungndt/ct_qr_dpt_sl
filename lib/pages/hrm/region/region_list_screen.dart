import 'package:erp/base/widget/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import 'bloc/region_bloc.dart';
import 'edit_region_screen.dart';
import 'new_region_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegionListScreen extends StatelessWidget {
  const RegionListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RegionBloc>(context).add(GetRegionEvent());
    return Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.area,
            style: const TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewRegionScreen()),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<RegionBloc, RegionState>(
          builder: (context, state) {
            if (state is RegionWaiting) {
              return const Center(
                  child: CircularProgressIndicator(color: mainColor));
            }
            if (state is RegionAddSuccess) {
              BlocProvider.of<RegionBloc>(context).add(GetRegionEvent());
            }
            if (state is RegionSuccess) {
              return (state.regionList.isEmpty)
                  ? const EmptyScreen()
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.regionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRegionScreen(
                                            regionModel:
                                                state.regionList[index])),
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
                                          state.regionList[index].name,
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
                                    const SizedBox(height: 2),
                          ),
                        ),
                      ],
                    );
            }
            return const EmptyScreen();
          },
        ));
  }
}
