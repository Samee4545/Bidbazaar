import 'package:bidbazaar/manageInventory/inventoryListTilesView.dart';
import 'package:bidbazaar/firebase%20copy/getOrdersData.dart';
import 'package:bidbazaar/firebase/upload&RetrieveData/uploadProductAdData.dart';
import 'package:bidbazaar/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderFeedbackModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/views/analysisReportView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bidbazaar/views/helpAndSupportView.dart';
import 'package:bidbazaar/views/myReviewsView.dart';
import 'package:bidbazaar/views/settingView.dart';
import 'package:bidbazaar/views/termsAndPolicyView.dart';
import 'package:bidbazaar/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar/widgets/viewWidgets/customAppBarView.dart';
import 'package:shimmer/shimmer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? myName, myProfilePic, myUserName, myEmail, myUserId;

  Future<void> getMyDetails() async {
    myName = await SharedPrefrenceHelper().getDisplayName();
    myProfilePic = await SharedPrefrenceHelper().getUserPic();
    myUserName = await SharedPrefrenceHelper().getUserName();
    myEmail = await SharedPrefrenceHelper().getUserEmail();
    myUserId = await SharedPrefrenceHelper().getUserId();
    setState(() {});
    _fetchProducts();
  }

  List<ConfirmOrderModel> userOrderModelData = [];
  List<ConfirmOrderModel> myOrders = [];
  List<OrderShippingModel> myOrderShippingModelData = [];
  List<OrderShippingModel> userOrderShipping = [];
  List<OrderFeedbackModel> orderFeedbackModelData = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getMyDetails();
  }

  Future<void> _fetchProducts() async {
    try {
      List<ConfirmOrderModel> userOrders =
          await getAllUsersOrderData(myUserId!);
      List<OrderShippingModel> userOrdersShipping =
          await getUserShippingData(myUserId!);
      List<OrderShippingModel> myOrdersShippingData =
          await getCurrUserShippingData(myUserId!);
      List<ConfirmOrderModel> myOrdersData =
          await getCurrUserOrderData(myUserId!);
      List<OrderFeedbackModel> feedbacks =
          await getCurrUserFeedbacks(myUserId!);
      if (mounted) {
        setState(() {
          userOrderModelData = userOrders;
          userOrderShipping = userOrdersShipping;
          myOrders = myOrdersData;
          myOrderShippingModelData = myOrdersShippingData;
          orderFeedbackModelData = feedbacks;
          isDataLoaded = true;
        });
      }
      setState(() {});
    } catch (e) {
      print("Error fetching products: $e");
      // Handle error appropriately, e.g., show a snackbar
    }
  }

  Future<void> _refreshData() async {
    await getMyDetails();
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildUserInfoSection(),
    );
  }

  Widget buildUserInfoSection() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            customAppBarView(context, "Account Settings", false),
            const SizedBox(height: 20),
            isDataLoaded
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                height: 90,
                                width: 90,
                                child: CachedNetworkImage(
                                  imageUrl: myProfilePic?.toString() ??
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myName.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyleH2(Colors.black),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    myEmail.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle300Weight(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InventoryListTilesView(
                                myOrders: myOrders,
                                myOrderShippingModelData:
                                    myOrderShippingModelData,
                                userOrderModelData: userOrderModelData,
                                userOrderShipping: userOrderShipping,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          "My orders",
                          style: textStyleH2(blackColor),
                        ),
                        subtitle: Text(
                          "Already have ${myOrderShippingModelData.length + userOrderShipping.length} orders",
                          style: textStyle300WeightLight(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyReviewsView(
                                orderFeedbackModelData: orderFeedbackModelData,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          "My reviews",
                          style: textStyleH2(blackColor),
                        ),
                        subtitle: Text(
                          "Reviews for ${orderFeedbackModelData.length} orders",
                          style: textStyle300WeightLight(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermAndPolicyView(),
                            ),
                          );
                        },
                        title: Text(
                          "Terms of Services",
                          style: textStyleH2(blackColor),
                        ),
                        subtitle: Text(
                          "Privacy and concerns",
                          style: textStyle300WeightLight(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnalysisReportScreen(
                                userId: myUserId.toString(),
                              ),
                            ),
                          );
                        },
                        title: Text(
                          "Analysis Report",
                          style: textStyleH2(blackColor),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpAndSupportView(),
                            ),
                          );
                        },
                        title: Text(
                          "Help and Support",
                          style: textStyleH2(blackColor),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingView(
                                fullName: myName,
                                userName: myUserName,
                                email: myEmail,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          "Setting",
                          style: textStyleH2(blackColor),
                        ),
                        subtitle: Text(
                          "Notifications, password",
                          style: textStyle300WeightLight(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  )
                : _buildShimmer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 14,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Shimmer effect for list items
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              ListTile(
                title: Container(
                  height: 16,
                  color: Colors.grey,
                ),
                subtitle: Container(
                  height: 12,
                  color: Colors.grey,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              // Repeat the shimmer effect for other list items
            ],
          ),
        ),
      ),
    );
  }
}
