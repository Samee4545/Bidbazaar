import 'package:bidbazaar/dashboard/pages/chatPage.dart';
import 'package:bidbazaar/dashboard/pages/faviroteProductsPage.dart';
import 'package:bidbazaar/dashboard/pages/forYouPage.dart';
import 'package:bidbazaar/dashboard/pages/profilePage.dart';
import 'package:bidbazaar/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/bottomNavigationModel.dart';
import 'package:bidbazaar/utilities/modelsData/dashBoardModelsData/bottomNavigationModelData.dart';
import 'package:bidbazaar/views/productPostCatagorySelectionView.dart';
import 'package:flutter/material.dart';

class DashBoardNavigationBar extends StatefulWidget {
  final int index;
  const DashBoardNavigationBar({super.key, required this.index});

  @override
  State<DashBoardNavigationBar> createState() => _DashBoardNavigationBarState();
}

class _DashBoardNavigationBarState extends State<DashBoardNavigationBar> {
  List<BottomNavigationModel> _bottomNavigationModelData = [];
  int? selectedIndex;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.index;
  }

  List<Widget> widgetsList = [
    ForYouPage(),
    FaviroteProductsPage(),
    ProductPostCatagorySelectionView(isPrePageFavirote: false),
    ChatPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: backgroundColor,
          extendBodyBehindAppBar: true,
          body: IndexedStack(
            children: widgetsList,
            index: selectedIndex,
          ),
          // Center(child: widgetsList[selectedIndex!]),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedItemColor: orangeButtonColor,
              unselectedItemColor: blackColor.withOpacity(.7),
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              currentIndex: selectedIndex!,
              items: const [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home_rounded),
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.favorite),
                    icon: Icon(Icons.favorite_outline),
                    label: "Saved"),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.add_circle),
                    icon: Icon(Icons.add_circle_outline),
                    label: "Add"),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.chat),
                    icon: Icon(Icons.chat_bubble_outline),
                    label: "Chat"),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.account_circle),
                    icon: Icon(Icons.account_circle_outlined),
                    label: "Account")
              ])
          // BottomAppBar(
          //   color: whiteColor,
          //   clipBehavior: Clip.hardEdge,
          //   shape: CircularNotchedRectangle(),
          //   notchMargin: 10,
          //   child: Container(
          //     margin: EdgeInsets.symmetric(vertical: 6),
          //     child: Row(
          //       children: [
          //         ...List.generate(_bottomNavigationModelData.length, (index) {
          //           BottomNavigationModel modelData =
          //               _bottomNavigationModelData[index];
          //           return Expanded(
          //               child: GestureDetector(
          //             onTap: () {
          //               selectedIndex = index;
          //               setState(() {});
          //             },
          //             child: Container(
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   selectedIndex == index
          //                       ? Icon(modelData.icon,
          //                           size: 26, color: modelData.color)
          //                       : Icon(modelData.alternateIcon,
          //                           size: 24,
          //                           color: Colors.black.withOpacity(.9)),
          //                   Text(
          //                     selectedIndex == index ? modelData.title ?? "" : "",
          //                     style:
          //                         TextStyle(color: modelData.color, fontSize: 12),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ));
          //         })
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
