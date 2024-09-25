// import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
// import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
// import 'package:bidbazaar_admin/views/UserViews/UsersList.dart';
// import 'package:bidbazaar_admin/views/UserViews/explore_posts.dart';
// import 'package:bidbazaar_admin/views/UserViews/explore_sales.dart';
// import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class UpdateUserScreen extends StatelessWidget {
//   final UserPersonalInfoModel user;

//   UpdateUserScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 customAppBarView(context, "", false),
//                 Positioned(
//                   top: 60,
//                   left: 20,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(100)),
//                         child: Container(
//                             height: 150,
//                             width: 150,
//                             child: CachedNetworkImage(
//                               imageUrl: user.profileImage! ??
//                                   'https://plus.unsplash.com/premium_photo-1680378871613-bfacb34787f8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
//                               fit: BoxFit.cover,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       CupertinoActivityIndicator(),
//                               errorWidget: (context, url, error) =>
//                                   Icon(Icons.error),
//                             )),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         '${user.userFullName}',
//                         style: TextStyle(
//                             fontSize: 30,
//                             fontFamily: "BriemHand",
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                     top: MediaQuery.of(context).size.height / 2.5,
//                     left: 10,
//                     right: 10,
//                     child: Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PostsScreen(
//                                           userId: user.userId!,
//                                         )));
//                           },
//                           child: Card(
//                             elevation: 4,
//                             color: whiteColor,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: 60,
//                               padding: EdgeInsets.all(16),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.article),
//                                   SizedBox(width: 10),
//                                   Text('Explore Posts'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         // Explore Sales Card
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ExploreEarningScreen(
//                                           userId: user.userId.toString(),
//                                         )));
//                           },
//                           child: Card(
//                             elevation: 4,
//                             color: whiteColor,
//                             child: Container(
//                               height: 60,
//                               width: MediaQuery.of(context).size.width,
//                               padding: EdgeInsets.all(16),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.shopping_cart),
//                                   SizedBox(width: 10),
//                                   Text('Explore Sales'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ))
//               ],
//             ),
//           ),
//           // Section for exploring sales
//         ],
//       ),
//     );
//   }
// }
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar_admin/views/UserViews/UsersList.dart';
import 'package:bidbazaar_admin/views/UserViews/explore_posts.dart';
import 'package:bidbazaar_admin/views/UserViews/explore_sales.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateUserScreen extends StatelessWidget {
  final String userId;

  UpdateUserScreen({required this.userId});

  Stream<UserPersonalInfoModel> getUserDataStream() {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users').child(userId);
    return userRef.onValue.map((event) {
      final Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
      return UserPersonalInfoModel.fromMap(data!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder<UserPersonalInfoModel>(
        stream: getUserDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data found.'));
          }

          UserPersonalInfoModel user = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    customAppBarView(context, "", false),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              height: 150,
                              width: 150,
                              child: CachedNetworkImage(
                                imageUrl: user.profileImage! ??
                                    'https://plus.unsplash.com/premium_photo-1680378871613-bfacb34787f8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${user.userFullName}',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: "BriemHand",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.5,
                      left: 10,
                      right: 10,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostsScreen(
                                    userId: user.userId!,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: whiteColor,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(Icons.article),
                                    SizedBox(width: 10),
                                    Text('Explore Posts'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Explore Sales Card
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExploreEarningScreen(
                                    userId: user.userId.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: whiteColor,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    SizedBox(width: 10),
                                    Text('Explore Sales'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
