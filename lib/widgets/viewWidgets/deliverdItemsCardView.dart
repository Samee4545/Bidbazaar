import 'package:bidbazaar_admin/utilities/commonUtilities/appColorUtility/appColors.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/confirmOrderModel.dart';
import 'package:bidbazaar_admin/utilities/models/dashBoardModels/orderShippingModel.dart';
import 'package:bidbazaar_admin/widgets/commonWidgets/textStyles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderItemsCardView(context, List<ConfirmOrderModel> orderModelData,
    OrderShippingModel orderShippingModel) {
  return ListView.builder(
    padding: const EdgeInsets.all(0),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: orderModelData.length,
    itemBuilder: (context, index) {
      return orderModelData[index].orderID == orderShippingModel.orderId
          ? Card(
              elevation: 4,
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Container(
                          height: 100,
                          color: Colors.orange,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl: orderModelData[index].image ??
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${orderModelData[index].productTitle}",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis)),
                              Row(
                                children: [
                                  Text("Price: ",
                                      style: textStyle300WeightLight()),
                                  Text(
                                    "${orderModelData[index].unitPrice}",
                                    style: textStyleH2(blackColor),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Unit: ",
                                      style: textStyle300WeightLight()),
                                  Text(
                                    "${orderModelData[index].unitQuantity}",
                                    style:
                                        textStyleSimpleTitle(FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox();
    },
  );
}
