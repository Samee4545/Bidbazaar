class UserPersonalInfoModel {
  String? profileImage;
  String? userFullName;
  String? userName;
  String? userEmail;
  String? userId;
  String? userPassword;
  String? accountCreatedDate;
  bool? buyer;
  bool? seller;

  UserPersonalInfoModel(
      {this.profileImage,
      this.userFullName,
      this.userName,
      this.userEmail,
      this.userId,
      this.buyer,
      this.accountCreatedDate,
      this.seller,
      this.userPassword});

  Map<String, dynamic> toJson() {
    return {
      "profileImage": profileImage,
      "userFullName": userFullName,
      "userName": userName,
      "userEmail": userEmail,
      "userId": userId,
      "buyer": buyer,
      "accountCreatedDate": accountCreatedDate,
      "seller": seller,
      "userPassword": userPassword
    };
  }

  factory UserPersonalInfoModel.fromMap(Map<dynamic, dynamic> map) {
    return UserPersonalInfoModel(
        profileImage: map["profileImage"],
        userFullName: map["userFullName"],
        userName: map["userName"],
        userEmail: map["userEmail"],
        userId: map["userId"],
        buyer: map["buyer"],
        accountCreatedDate: map["accountCreatedDate"],
        seller: map["seller"],
        userPassword: map["userPassword"]);
  }
}
