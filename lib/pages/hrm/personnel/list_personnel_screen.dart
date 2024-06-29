import 'package:erp/config/color.dart';
import 'package:erp/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_personnel_screen.dart';
import '../../../method/hrm_method.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListPersonnelScreen extends StatelessWidget {
  const ListPersonnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0.1,
        title: Text(
          AppLocalizations.of(context)!.listEmployee,
          style: const TextStyle(color: blueBlack),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return Dialog(
          //                 // shape: const RoundedRectangleBorder(
          //                 //     borderRadius:
          //                 //         BorderRadius.all(Radius.circular(10.0))),
          //                 child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     Navigator.pop(context);

          //                     Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) =>
          //                               const AddPersonnelScreen()),
          //                     );
          //                   },
          //                   child: const ListTile(
          //                     title: Text(
          //                       'Thêm nhân viên',
          //                       style: TextStyle(fontSize: 17),
          //                     ),
          //                   ),
          //                 ),
          //                 const ListTile(
          //                   title: Text(
          //                     'Thêm từ danh bạ',
          //                     style: TextStyle(fontSize: 17),
          //                   ),
          //                 ),
          //                 const ListTile(
          //                   title: Text(
          //                     'Mời qua liên kết',
          //                     style: TextStyle(fontSize: 17),
          //                   ),
          //                 ),
          //                 const ListTile(
          //                   title: Text('Hủy'),
          //                 )
          //               ],
          //             ));
          //           });
          //     },
          //     icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: backgroundColor,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            //contentPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.only(left: 15),
                            hintText: 'Tìm kiếm',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // InkWell(
              //   onTap: () {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //       builder: (context) => const FilterPersonnelScreen()),
              //     // );
              //   },
              //   child: Container(
              //     height: 50,
              //     width: 50,
              //     decoration: BoxDecoration(
              //         color: const Color(0xFFdce7f9),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Icon(Icons.tune),
              //   ),
              // )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  builPersonnel(context, User.name,
                      AppLocalizations.of(context)!.employee),
                  Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[200]),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

Widget builPersonnel(BuildContext context, String name, String position) {
  return InkWell(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => CheckInScreen(
      //             name: name,
      //           )),
      // );
    },
    child: Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xFFB3C0E0),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(
                height: 5,
              ),
              Text(
                position,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          )),
          InkWell(
            onTap: () async {
              final call = Uri.parse('tel:+84987654321');
              if (await canLaunchUrl(call)) {
                launchUrl(call);
              } else {
                throw 'Could not launch $call';
              }
            },
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: const Icon(
                Icons.phone,
                size: 25,
                color: mainColor,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
