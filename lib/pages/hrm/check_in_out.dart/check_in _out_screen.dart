import 'package:erp/base/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickalert/quickalert.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import '../location/chosse_location_screen.dart';
import '../../../base/screen/choose_shift_screen.dart';
import '../work/bloc/work_bloc.dart';
import 'bloc/check_in_out_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckInOutScreen extends StatefulWidget {
  const CheckInOutScreen({super.key});
  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  Position? currentPosition;
  bool loading = false;
  late CheckInOutBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<CheckInOutBloc>(context);
    bloc.add(InitialCheckInOutEvent());
    super.initState();
  }

  Future determinePosition() async {
    loading = true;
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loading = false;
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Location services are disabled.',
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        loading = false;
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'Location permissions are denied',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      loading = false;
      setState(() {});
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    currentPosition = await Geolocator.getCurrentPosition();
    loading = false;
    setState(() {
      currentPosition = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context)!.chooseShift,
          style: const TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.clear, color: blueGrey1),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: BlocListener<CheckInOutBloc, CheckInOutState>(
        listener: (context, blocState) {
          if (blocState.confirmStatus ==
              CheckInOutConfirmStatus.loadingConfirm) {
            showProgressDialog(context);
          } else if (blocState.confirmStatus ==
              CheckInOutConfirmStatus.successConfirm) {
            //  Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // BlocProvider.of<WorkBloc>(context)
            //     .add(CheckInEvent(shiftModel: blocState.shiftModel!));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<CheckInOutBloc, CheckInOutState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (loading)
                      ? const Loading()
                      : currentPosition != null
                          ? SizedBox(
                              height: 300,
                              child: GoogleMap(
                                zoomGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                tiltGesturesEnabled: false,
                                rotateGesturesEnabled: false,
                                zoomControlsEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                    zoom: 16.5),
                                // onMapCreated: (GoogleMapController controller) {
                                //   _controller.complete(controller);
                                // },
                                circles: {
                                  Circle(
                                    circleId: const CircleId("myCircle"),
                                    radius: 150,
                                    center: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                    fillColor: const Color.fromRGBO(
                                        100, 100, 100, 0.3),
                                    strokeWidth: 0,
                                  )
                                },
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("myMarker"),
                                    draggable: false,
                                    position: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                  )
                                },
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${AppLocalizations.of(context)!.attendanceNotify} ('),
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .detail,
                                              style: const TextStyle(
                                                  color: mainColor)),
                                          const TextSpan(text: ')'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              backgroundColor: mainColor),
                                          onPressed: () {
                                            showCupertinoDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoAlertDialog(
                                                title: const Text(
                                                    'Quyền truy cập vị trí'),
                                                content: const Column(
                                                  children: [
                                                    Text(
                                                        'Ứng dụng cần được cấp quyền truy cập vị trí để thực hiện chức năng lấy chính xác vị trí trong quá trình chấm công'),
                                                  ],
                                                ),
                                                actions: <CupertinoDialogAction>[
                                                  CupertinoDialogAction(
                                                    child: const Text('No'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    isDestructiveAction: true,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      determinePosition();
                                                    },
                                                    child: const Text('Yes'),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.allow,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ]),
                            ),
                  currentPosition == null
                      ? Container()
                      : Text(
                          '(Latitude: ${currentPosition?.latitude}, longtitude: ${currentPosition?.longitude})',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
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
                                  child: state.shiftModel == null
                                      ? Text(
                                          AppLocalizations.of(context)!
                                              .chooseShift,
                                          style: const TextStyle(
                                              color: blueGrey2, fontSize: 16))
                                      : Text(
                                          capitalize(state.shiftModel!.title),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: blueBlack, fontSize: 16))),
                              const Icon(Icons.arrow_forward_ios,
                                  color: blueGrey1, size: 22)
                            ],
                          )),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseShiftScreen(
                                    listShiftModel: state.listShiftModel,
                                    screen: 'check_in_out',
                                  )),
                        );
                        BlocProvider.of<WorkBloc>(context).add(CheckInEvent());
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
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
                                  child: state.locationModel == null
                                      ? Text(
                                          AppLocalizations.of(context)!
                                              .chooseLocation,
                                          style: const TextStyle(
                                              color: blueGrey2, fontSize: 16))
                                      : Text(state.locationModel!.name,
                                          style: const TextStyle(
                                              color: blueBlack, fontSize: 16))),
                              const Icon(Icons.arrow_forward_ios,
                                  color: blueGrey1, size: 22)
                            ],
                          )),
                      onTap: () async {
                        List<LocationModel> locationList =
                            await ApiProvider().getLocation();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLocationScreen(
                                    locationList: locationList,
                                  )),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: mainColor),
                        onPressed: () async {
                          if (loading) return;
                          if (state.shiftModel == null) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return closeDialog(context, 'Thông báo',
                                      'Vui lòng chọn ca làm việc');
                                });
                            return;
                          }
                          if (state.locationModel == null) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return closeDialog(context, 'Thông báo',
                                      'Vui lòng chọn vị trí');
                                });
                            return;
                          }

                          if (currentPosition == null) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text: 'Không tìm thấy vị trí hiện tại',
                            );
                            return;
                          }
                          double distanceInMeters = Geolocator.distanceBetween(
                              currentPosition!.latitude,
                              currentPosition!.longitude,
                              state.locationModel!.lat!,
                              state.locationModel!.lng!);
                          if (distanceInMeters > state.locationModel!.radius) {
                            return QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              text:
                                  'Khoảng cách chấm công không hợp lệ($distanceInMeters > ${state.locationModel!.radius})',
                            );
                          }
                          bloc.add(CheckInPostEvent(
                              id: -1,
                              employeeID: UserModel.id.toString(),
                              authDate: DateTime.now().toString(),
                              authTime: DateTime.now().toString(),
                              locationID: 1,
                              token: User.token));
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.confirm,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white))),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
