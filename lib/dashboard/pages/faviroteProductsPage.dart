import 'package:bidbazaar/firebase/upload&RetrieveData/uploadProductAdData.dart';
import 'package:bidbazaar/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/catagoriesModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/productGridModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
import 'package:bidbazaar/utilities/modelsData/dashBoardModelsData/catagoriesModelData.dart';
import 'package:bidbazaar/utilities/modelsData/dashBoardModelsData/productGridModelData.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/catagoriesListView.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/productsGridView.dart';
import 'package:bidbazaar/widgets/viewWidgets/customAppBarView.dart';
import 'package:flutter/material.dart';

class FaviroteProductsPage extends StatefulWidget {
  const FaviroteProductsPage({super.key});

  @override
  State<FaviroteProductsPage> createState() => _FaviroteProductsPageState();
}

class _FaviroteProductsPageState extends State<FaviroteProductsPage> {
  List<CatagoriesModel> catagoriesListData = [];
  List<UploadedProductAdModel> productGridListData = [];

  @override
  void initState() {
    super.initState();
    catagoriesListData = getCatagoriesModelData(context);
    catagoriesListData = getCatagoriesModelData(context);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBarView(context, "Favorite", false),
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: catagoriesListView(context, catagoriesListData, true)),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ProductGridView(
                      catagoryName: 'fav',
                      isPrePageFavirote: true,
                      getFav: true)),
            ],
          ),
        ),
      ),
    );
  }
}
