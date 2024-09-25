import 'package:bidbazaar/firebase/upload&RetrieveData/uploadProductAdData.dart';
import 'package:bidbazaar/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/cartModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/catagoriesModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/drawerModel.dart';
import 'package:bidbazaar/utilities/models/dashBoardModels/uplodedProductAdModel.dart';
import 'package:bidbazaar/utilities/modelsData/dashBoardModelsData/catagoriesModelData.dart';
import 'package:bidbazaar/utilities/modelsData/dashBoardModelsData/drawerModelData.dart';
import 'package:bidbazaar/utilities/sharedPreference/sharedPreference.dart';
import 'package:bidbazaar/views/cartView.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/appBarTitle.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/catagoriesListView.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/drawerView.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/productsGridView.dart';
import 'package:bidbazaar/widgets/forYouPageWidgets/sliderAndSearchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key});

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Color _appBarColor = Colors.transparent;
  bool appBarColorChange = false;
  double _elevation = 0.0;

  List<DrawerModel> drawerModelData = [];
  List<CatagoriesModel> catagoriesModelData = [];
  List<UploadedProductAdModel> productGridListData = [];
  String? myName, myProfilePic;

  Future<void> getMyDetails() async {
    myName = await SharedPrefrenceHelper().getDisplayName();
    myProfilePic = await SharedPrefrenceHelper().getUserPic();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    drawerModelData = getDrawerModelData(context);
    catagoriesModelData = getCatagoriesModelData(context);
    _fetchProducts();
    getMyDetails();
  }

  Future<void> _fetchProducts() async {
    try {
      List<UploadedProductAdModel> products =
          await getProductsDataFromDatabase();
      if (mounted) {
        setState(() {
          productGridListData = products;
        });
      }
    } catch (e) {
      print("Error fetching products: $e");
      // Handle error appropriately, e.g., show a snackbar
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final double offset = _scrollController.offset;

    if (offset <= 4) {
      setState(() {
        screenScrolled = false;
        _elevation = 0;
        appBarColorChange = false;
        _appBarColor = Colors.transparent;
      });
    } else if (offset <= 40) {
      setState(() {
        _appBarColor = ColorTween(
          begin: Colors.transparent,
          end: Colors.white,
        ).transform((offset - 20) / 20)!;
      });
    } else if (offset >= 100) {
      setState(() {
        screenScrolled = true;
      });
    } else {
      setState(() {
        appBarColorChange = true;
        _elevation = 8;
        _appBarColor = Colors.white;
      });
    }
  }

  TextEditingController _searchController = TextEditingController();

  bool screenScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: appBarTitle(context, appBarColorChange, screenScrolled,
              _searchController, productGridListData),
          backgroundColor: _appBarColor,
          elevation: _elevation,
          leading: Builder(
            builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: appBarColorChange ? blackColor : whiteColor,
                  ));
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartView()));
              },
              icon: Badge(
                label: Text(
                    "${ScopedModel.of<CartModel>(context, rebuildOnChange: true).cart.length}"),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: appBarColorChange ? blackColor : whiteColor,
                ),
              ),
            )
          ],
        ),
        drawer: drawerView(context, drawerModelData, myName.toString(),
            myProfilePic.toString()),
        extendBodyBehindAppBar: true,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                sliderAndSearchBar(
                    context, screenScrolled, productGridListData),
                Padding(
                    padding: const EdgeInsets.all(4),
                    child: catagoriesListView(
                        context, catagoriesModelData, false)),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ProductGridView(
                      getFav: false,
                      catagoryName: '',
                      isPrePageFavirote: false,
                    )),
              ],
            ),
          ),
        ));
  }
}
