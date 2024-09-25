class CurrentUserOrdersPriceStatusModel {
  int? orderAmount;
  bool? amountPending;
  String? amountConfirmationDate;

  CurrentUserOrdersPriceStatusModel(
      {this.orderAmount, this.amountPending, this.amountConfirmationDate});

  Map<String, dynamic> toJson() {
    return {
      "orderAmount": orderAmount,
      "amountPending": amountPending,
      "amountConfirmationDate": amountConfirmationDate
    };
  }

  factory CurrentUserOrdersPriceStatusModel.fromMap(Map<dynamic, dynamic> map) {
    return CurrentUserOrdersPriceStatusModel(
        orderAmount: map["orderAmount"],
        amountPending: map["amountPending"],
        amountConfirmationDate: map["amountConfirmationDate"]);
  }
}
