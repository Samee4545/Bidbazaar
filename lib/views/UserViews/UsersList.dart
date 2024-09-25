import 'package:bidbazaar_admin/firebase/getUserPersonalData.dart';
import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:bidbazaar_admin/views/UserViews/updateUserScreen.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar_admin/widgets/viewWidgets/customImageAppBarView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String filterOption = 'All'; // Default filter option
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.reference().child('users');
  late Stream<List<UserPersonalInfoModel>> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = getUsersDataStream();
  }

  Stream<List<UserPersonalInfoModel>> getUsersDataStream() {
    return _databaseRef.onValue.map((event) {
      final Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
      if (data == null) return [];
      return data.entries.map((entry) {
        return UserPersonalInfoModel.fromMap(
            {...entry.value, 'users': entry.key});
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: StreamBuilder<List<UserPersonalInfoModel>>(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerEffect();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No users found.'));
            }

            List<UserPersonalInfoModel> users = snapshot.data!;
            List<UserPersonalInfoModel> filteredUsers = users.where((user) {
              if (filterOption == 'All') {
                return true;
              } else if (filterOption == 'Both') {
                return user.buyer == true && user.seller == true;
              } else if (filterOption == 'Buyer') {
                return user.buyer == true;
              } else {
                return user.seller == true;
              }
            }).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      customAppBarView(context, "Users", true),
                      users.isNotEmpty
                          ? Positioned(
                              bottom: 4,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.filter_alt),
                                onPressed: () {
                                  _showFilterOptions(context);
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  for (int index = 0; index < filteredUsers.length; index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    child: Container(
                                      height: 54,
                                      width: 54,
                                      child: CachedNetworkImage(
                                        imageUrl: filteredUsers[index]
                                                .profileImage ??
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
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredUsers[index].userFullName ??
                                              'No Name',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateUserScreen(
                                            userId: filteredUsers[index]
                                                .userId
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text("Update User"),
                                            Icon(Icons.update),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'buyer',
                                    groupValue: filteredUsers[index].buyer ==
                                                true &&
                                            filteredUsers[index].seller == false
                                        ? "buyer"
                                        : '',
                                    onChanged: (String? newValue) {},
                                  ),
                                  Text('Buyer'),
                                  SizedBox(width: 8),
                                  Radio<String>(
                                    value: 'seller',
                                    groupValue: filteredUsers[index].buyer ==
                                                false &&
                                            filteredUsers[index].seller == true
                                        ? "seller"
                                        : '',
                                    onChanged: (String? newValue) {},
                                  ),
                                  Text('Seller'),
                                  SizedBox(width: 8),
                                  Radio<String>(
                                    value: 'both',
                                    groupValue: filteredUsers[index].buyer ==
                                                true &&
                                            filteredUsers[index].seller == true
                                        ? "both"
                                        : '',
                                    onChanged: (String? newValue) {},
                                  ),
                                  Text('Both'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 24),
          height: MediaQuery.of(context).size.height * 0.3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apply Filter",
                      style: textStyleH3(Colors.black),
                    ),
                    InkWell(
                      child: Icon(Icons.cancel),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('All'),
                  onTap: () {
                    setState(() {
                      filterOption = 'All';
                    });
                    Navigator.pop(context);
                  },
                  selected: filterOption == 'All',
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Buyer'),
                  onTap: () {
                    setState(() {
                      filterOption = 'Buyer';
                    });
                    Navigator.pop(context);
                  },
                  selected: filterOption == 'Buyer',
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Seller'),
                  onTap: () {
                    setState(() {
                      filterOption = 'Seller';
                    });
                    Navigator.pop(context);
                  },
                  selected: filterOption == 'Seller',
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Both'),
                  onTap: () {
                    setState(() {
                      filterOption = 'Both';
                    });
                    Navigator.pop(context);
                  },
                  selected: filterOption == 'Both',
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              customAppBarView(context, "Users", true),
              Positioned(
                bottom: 4,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: () {
                    _showFilterOptions(context);
                  },
                ),
              )
            ],
          ),
          Column(
            children: List.generate(5, (index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Container(
                                  height: 54,
                                  width: 54,
                                  color: Colors.grey[300],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 16,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: '',
                                groupValue: '',
                                onChanged: (String? newValue) {},
                              ),
                              Text('Buyer'),
                              SizedBox(width: 8),
                              Radio<String>(
                                value: '',
                                groupValue: '',
                                onChanged: (String? newValue) {},
                              ),
                              Text('Seller'),
                              SizedBox(width: 8),
                              Radio<String>(
                                value: '',
                                groupValue: '',
                                onChanged: (String? newValue) {},
                              ),
                              Text('Both'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
