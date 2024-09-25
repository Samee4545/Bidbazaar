// import 'package:bidbazaar_admin/firebase/getProductsFromDB.dart';
// import 'package:bidbazaar_admin/firebase/getUserPersonalData.dart';
// import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
// import 'package:bidbazaar_admin/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
// import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
// import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// class PostsScreen extends StatefulWidget {
//   final String userId;
//   const PostsScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _PostsScreenState createState() => _PostsScreenState();
// }

// class _PostsScreenState extends State<PostsScreen> {
//   List<UploadedProductAdModel> productDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchUsers();
//   }

//   Future<void> _fetchUsers() async {
//     try {
//       EasyLoading.show(status: 'Loading...');
//       List<UploadedProductAdModel> users =
//           await getProductsDataFromDatabase(widget.userId);
//       if (mounted) {
//         setState(() {
//           productDataList = users;
//         });
//       }
//       EasyLoading.dismiss();
//     } catch (e) {
//       EasyLoading.dismiss();
//       print("Error fetching products: $e");
//       // Handle error appropriately, e.g., show a snackbar
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: backgroundColor,
//         body: productDataList.isNotEmpty
//             ? Column(
//                 children: [
//                   customAppBarView(context, "Posts", true),
//                   GridView.builder(
//                     padding: EdgeInsets.zero,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: productDataList.length,
//                     shrinkWrap: true,
//                     gridDelegate:
//                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                             maxCrossAxisExtent: 200,
//                             mainAxisExtent: 300,
//                             crossAxisSpacing: 1,
//                             mainAxisSpacing: 1),
//                     itemBuilder: (context, index) {
//                       return Stack(
//                         children: [
//                           Container(
//                             child: Card(
//                               elevation: 4,
//                               color: whiteColor,
//                               child: Column(
//                                 children: [
//                                   Stack(children: [
//                                     ClipRRect(
//                                       borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(12),
//                                           topRight: Radius.circular(12)),
//                                       child: SizedBox(
//                                           height: 200,
//                                           width: double.infinity,
//                                           child: CachedNetworkImage(
//                                             imageUrl: productDataList[index]
//                                                     .images![0] ??
//                                                 'https://plus.unsplash.com/premium_photo-1680378871613-bfacb34787f8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
//                                             fit: BoxFit.cover,
//                                             progressIndicatorBuilder: (context,
//                                                     url, downloadProgress) =>
//                                                 CupertinoActivityIndicator(),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                           )),
//                                     ),
//                                   ]),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                               productDataList[index]
//                                                   .productTitle!,
//                                               maxLines: 1,
//                                               style: textStyleSimpleTitle(
//                                                   FontWeight.w900)),
//                                           const SizedBox(height: 4),
//                                           Text(
//                                               productDataList[index]
//                                                   .productDescription!,
//                                               maxLines: 2,
//                                               style: textStyleSimpleTitle(
//                                                   FontWeight.w400))
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                               top: 12,
//                               right: 12,
//                               child: InkWell(
//                                 onTap: () async {
//                                   bool? confirmed =
//                                       await showDeleteConfirmationDialog(
//                                           context);
//                                   if (confirmed == true) {
//                                     await deleteProduct(productDataList[index]
//                                         .productAdId
//                                         .toString());
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                           content: Text(
//                                               'Product deleted successfully')),
//                                     );
//                                   }
//                                 },
//                                 // => _deleteProduct(index),
//                                 child: ClipOval(
//                                   child: Container(
//                                     height: 34,
//                                     width: 34,
//                                     color: Colors.black.withOpacity(.6),
//                                     child: const Icon(
//                                       Icons.delete,
//                                       color: Colors.white,
//                                       size: 22,
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               )
//             : Center(child: Text("User posts are not exist")));
//   }

//   Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
//     return showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete this product?'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Delete'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> deleteProduct(String productId) async {
//     try {
//       EasyLoading.show(status: 'Please wait...');
//       final DatabaseReference _ref =
//           FirebaseDatabase.instance.reference().child('productAds/$productId');

//       await _ref.remove();
//       EasyLoading.dismiss();
//     } catch (e) {
//       print(e.toString());
//       EasyLoading.dismiss();
//     }
//   }
// }
import 'package:bidbazaar_admin/firebase/getProductsFromDB.dart';
import 'package:bidbazaar_admin/firebase/getUserPersonalData.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';

class PostsScreen extends StatefulWidget {
  final String userId;
  const PostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Stream<List<UploadedProductAdModel>> getProductDataStream(String userId) {
    final Query productRef = FirebaseDatabase.instance
        .reference()
        .child('productAds')
        .orderByChild('userId')
        .equalTo(userId);

    return productRef.onValue.map((event) {
      final List<UploadedProductAdModel> productList = [];
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic>? productMap = event.snapshot.value as Map?;
        productMap!.forEach((key, value) {
          productList.add(UploadedProductAdModel.fromMap(value));
        });
      }
      return productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder<List<UploadedProductAdModel>>(
        stream: getProductDataStream(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('User posts do not exist'));
          }

          List<UploadedProductAdModel> productDataList = snapshot.data!;

          return Column(
            children: [
              customAppBarView(context, "Posts", true),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: productDataList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          child: Card(
                            elevation: 4,
                            color: whiteColor,
                            child: Column(
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: productDataList[index]
                                                .images![0] ??
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
                                ]),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productDataList[index].productTitle!,
                                          maxLines: 1,
                                          style: textStyleSimpleTitle(
                                              FontWeight.w900),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          productDataList[index]
                                              .productDescription!,
                                          maxLines: 2,
                                          style: textStyleSimpleTitle(
                                              FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: InkWell(
                            onTap: () async {
                              bool? confirmed =
                                  await showDeleteConfirmationDialog(context);
                              if (confirmed == true) {
                                await deleteProduct(productDataList[index]
                                    .productAdId
                                    .toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Product deleted successfully')),
                                );
                              }
                            },
                            child: ClipOval(
                              child: Container(
                                height: 34,
                                width: 34,
                                color: Colors.black.withOpacity(.6),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this product?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProduct(String productId) async {
    try {
      EasyLoading.show(status: 'Please wait...');
      final DatabaseReference _ref =
          FirebaseDatabase.instance.reference().child('productAds/$productId');

      await _ref.remove();
      EasyLoading.dismiss();
    } catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
    }
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        customAppBarView(context, "Posts", true),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6, // Number of shimmer cards to show
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 300,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: double.infinity,
                              height: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
