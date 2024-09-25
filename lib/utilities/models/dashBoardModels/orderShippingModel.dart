class OrderShippingModel {
  String? shippingAmount;
  String? street;
  String? building;
  String? city;
  String? emailAddress;
  String? phoneNumber;
  String? orderStatus;
  int? orderId;
  String? buyerId;
  String? apartment;
  String? trackingStatus;
  String? trackingNumber;
  int? itemsQuantity;
  String? orderTotalPrice;
  String? orderConfirmationDate;
  String? buyyerName;

  OrderShippingModel(
      {this.shippingAmount,
      this.street,
      this.building,
      this.city,
      this.emailAddress,
      this.phoneNumber,
      this.orderStatus,
      this.orderId,
      this.buyerId,
      this.trackingNumber,
      this.trackingStatus,
      this.itemsQuantity,
      this.orderTotalPrice,
      this.orderConfirmationDate,
      this.buyyerName,
      this.apartment});

  Map<String, dynamic> toJson() {
    return {
      "shippingAmount": shippingAmount,
      "street": street,
      "building": building,
      "city": city,
      "emailAddress": emailAddress,
      "phoneNumber": phoneNumber,
      "orderId": orderId,
      "trackingNumber": trackingNumber,
      "orderStatus": orderStatus,
      "trackingStatus": trackingStatus,
      "apartment": apartment,
      "buyerId": buyerId,
      "itemsQuantity": itemsQuantity,
      "buyyerName": buyyerName,
      "orderConfirmationDate": orderConfirmationDate,
      "orderTotalPrice": orderTotalPrice
    };
  }

  factory OrderShippingModel.fromMap(Map<dynamic, dynamic> map) {
    return OrderShippingModel(
        shippingAmount: map["shippingAmount"],
        street: map["street"],
        building: map["building"],
        city: map["city"],
        emailAddress: map["emailAddress"],
        phoneNumber: map["phoneNumber"],
        orderStatus: map["orderStatus"],
        trackingNumber: map["trackingNumber"],
        orderId: map["orderId"],
        buyerId: map["buyerId"],
        trackingStatus: map["trackingStatus"],
        itemsQuantity: map["itemsQuantity"],
        buyyerName: map["buyyerName"],
        orderTotalPrice: map["orderTotalPrice"],
        orderConfirmationDate: map["orderConfirmationDate"],
        apartment: map["apartment"]);
  }
}
