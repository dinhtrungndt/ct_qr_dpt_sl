// import 'package:flutter/material.dart';
// import '../../../config/constant.dart';
// import '../color.dart';
// import '../hrm_model/request_management_model.dart';


// class FilterRequestScreen extends StatelessWidget {
//   const FilterRequestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     FilterRequestController controller = Get.put(FilterRequestController());
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: const Text(
//             'Lọc',
//             style: TextStyle(color: blueBlack),
//           ),
//           iconTheme: const IconThemeData(color: blueBlack),
//           elevation: 1,
//         ),
//         body: Container(
//           color: mainColor.withOpacity(0.05),
//           child: Column(
//             children: [
//               const SizedBox(height: 5),
//               Expanded(
//                   child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Obx(() => buildListFilterRequest(
//                         controller.listFilterRequestModel,
//                         controller.modelID.value,
//                         (int id) =>
//                             controller.setSelectFilterRequestModel(id))),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                         height: double.infinity,
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Obx(() => buildListFilterRequestDetail(
//                             controller.modelID.value,
//                             controller.listFilterRequestDetailModel,
//                             controller.requestGroup.value,
//                             (int value) => controller
//                                 .setSelectFilterRequestDetailModel(value)))),
//                   )
//                 ],
//               )),
//               Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.all(15),
//                 child: Row(children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 60,
//                       child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             // primary: mainColor,
//                             backgroundColor: Colors.white,
//                             padding: EdgeInsets.zero,
//                             side: BorderSide(color: mainColor, width: 1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                           child: Text('XÓA LỌC',
//                               style: TextStyle(fontSize: 17, color: mainColor)),
//                           onPressed: () {
//                             controller.requestGroup.value = 0;
//                           }),
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: SizedBox(
//                       height: 60,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               elevation: 0.0,
//                               shadowColor: Colors.transparent,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15)),
//                               // primary: mainColor,
//                               backgroundColor: mainColor),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             "LỌC",
//                             style: TextStyle(fontSize: 17),
//                           )),
//                     ),
//                   ),
//                 ]),
//               )
//             ],
//           ),
//         ));
//   }
// }

// Widget buildListFilterRequest(
//     List<FilterRequestModel> listModel, int selectID, Function(int) selected) {
//   return Column(
//     children: [
//       for (FilterRequestModel frm in listModel)
//         InkWell(
//           onTap: () => selected(frm.id),
//           child: Container(
//             height: 50,
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.only(left: 10),
//             color: selectID == frm.id
//                 ? mainColor.withOpacity(0.15)
//                 : Colors.transparent,
//             child: Text(
//               frm.name,
//               style: TextStyle(
//                   fontSize: 17,
//                   color: selectID == frm.id
//                       ? mainColor
//                       : blueBlack.withOpacity(0.7)),
//             ),
//           ),
//         ),
//     ],
//   );
// }

// Widget buildListFilterRequestDetail(
//     int selextID,
//     List<FilterRequestDetailModel> listModel,
//     int groupValue,
//     Function(int) selected) {
//   return selextID != 1
//       ? const SizedBox.shrink()
//       : SingleChildScrollView(
//           child: Theme(
//             data: ThemeData(unselectedWidgetColor: mainColor),
//             child: Column(
//               children: [
//                 for (FilterRequestDetailModel frm in listModel)
//                   InkWell(
//                     onTap: () => selected(frm.id),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 45,
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 frm.name,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 16, color: blueBlack),
//                               ),
//                               Radio<int>(
//                                 value: frm.id,               
//                                 activeColor: mainColor,
//                                 groupValue: groupValue,
//                                 onChanged: (intdex) {
//                                   selected(frm.id);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(height: 1, color: Colors.grey[200]),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
// }
