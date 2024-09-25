import 'package:bidbazaar/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/chatPageTileModel.dart';
import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/views/buyyerMessagesView.dart';
import 'package:bidbazaar/widgets/commonWidgets/textStyles.dart';
import 'package:bidbazaar/widgets/viewWidgets/customAppBarView.dart';
import 'package:bidbazaar/widgets/viewWidgets/messagerProfileView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatPageTileModel> chatTileModelList = [];
  bool dataChecked = false;

  String? myName, myProfilePic, myUserName, myEmail, myUserId;
  Future<void> getMyDetails() async {
    myName = await SharedPrefrenceHelper().getDisplayName();
    myProfilePic = await SharedPrefrenceHelper().getUserPic();
    myUserName = await SharedPrefrenceHelper().getUserName();
    myEmail = await SharedPrefrenceHelper().getUserEmail();
    myUserId = await SharedPrefrenceHelper().getUserId();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchChatTiles();
    dataChecked = true;
    setState(() {});
  }

  _fetchChatTiles() async {
    await getMyDetails();
    chatTileModelList = await getChatRoomTileData(myName!.toUpperCase());
    setState(() {});
  }

  Future<void> _refreshData() async {
    await getMyDetails();
    chatTileModelList = await getChatRoomTileData(myName!.toUpperCase());
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: chatTileModelList.isEmpty
          ? Center(
              child: dataChecked
                  ? Text("No data exist")
                  : CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: Column(
                children: [
                  customAppBarView(context, "Chats", false),
                  Container(
                    margin: EdgeInsets.all(4),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: chatTileModelList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuyyerMessagesView(
                                          imageUrl: chatTileModelList[index]
                                              .receiverProfileImage!,
                                          name: chatTileModelList[index]
                                              .lastMessageReceiveTo!
                                              .toString(),
                                          subTitle: "",
                                        )));
                          },
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: chatTileModelList[index]
                                      .receiverProfileImage!,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                chatTileModelList[index].lastMessageReceiveTo!,
                                style: textStyleH2(blackColor),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<List<ChatPageTileModel>> getChatRoomTileData(String name) async {
    final DatabaseReference _ref =
        FirebaseDatabase.instance.reference().child('ChatRoom');
    List<ChatPageTileModel> data = [];

    DataSnapshot snapshot = (await _ref.once()).snapshot;
    Map<dynamic, dynamic>? values = snapshot.value as Map?;
    if (values != null) {
      values.forEach((key, value) {
        ChatPageTileModel chatData = ChatPageTileModel.fromMap(value);
        if (chatData.lastMessageReceiveTo!.toUpperCase() == name ||
            chatData.lastMessageSendBy!.toUpperCase() == name) {
          print("---------------------------");
          print(chatData.lastMessageReceiveTo!.toUpperCase());
          print(name);
          data.add(chatData);
        }
      });
    }

    return data;
  }
}
