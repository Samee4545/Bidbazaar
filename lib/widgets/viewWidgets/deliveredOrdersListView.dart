// import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
// import 'package:bidbazaar_admin/views/Manage%20Inventory/orderStatusDetailView.dart';
// import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
// import 'package:bidbazaar_admin/widgets/viewWidgets/commonOutlinedButton.dart';
// import 'package:flutter/material.dart';

// Widget deliverdOrderListView(context) {
//   return ListView.builder(
//     itemCount: 8,
//     padding: const EdgeInsets.all(0),
//     physics: const NeverScrollableScrollPhysics(),
//     shrinkWrap: true,
//     itemBuilder: (context, index) {
//       return Card(
//         elevation: 4,
//         child: SizedBox(
//           height: 190,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Order No. 1923067",
//                       style: textStyleH2(blackColor),
//                     ),
//                     Text("03-11-2023", style: textStyle300WeightLight())
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text("Tracking number: ", style: textStyle300WeightLight()),
//                     Text(
//                       "IW3464238643",
//                       style: textStyleSimpleTitle(FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Text("Quantity: ", style: textStyle300WeightLight()),
//                         Text(
//                           "6",
//                           style: textStyleSimpleTitle(FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text("Total Amount: ",
//                             style: textStyle300WeightLight()),
//                         Text(
//                           "2500/-",
//                           style: textStyleSimpleTitle(FontWeight.bold),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => OrderStatusDetailView(
//                                       orderStatus: "delivered",
//                                     )));
//                       },
//                       child: SizedBox(
//                         width: 100,
//                         child: commonOutlinedButton(
//                             context, "Details", commonButtonColor),
//                       ),
//                     ),
//                     Text(
//                       "Delivered",
//                       style: textStyleH3(Colors.green),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
