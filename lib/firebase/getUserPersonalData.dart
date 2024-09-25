import 'package:bidbazaar_admin/utilities/models/dashBoardModels/userPersonalInfoModel.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<UserPersonalInfoModel>> getUserPersonalInfoFromDatabase() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users');
  List<UserPersonalInfoModel> users = [];

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      users.add(UserPersonalInfoModel.fromMap(value));
    });
  }

  return users;
}

Future<Map<String, int>> getUsersInfoFromDatabase() async {
  final DatabaseReference _ref =
      FirebaseDatabase.instance.reference().child('users');

  int buyerCount = 0;
  int sellerCount = 0;
  int bothCount = 0;
  int currentMonthUserCount = 0;

  DataSnapshot snapshot = (await _ref.once()).snapshot;
  Map<dynamic, dynamic>? values = snapshot.value as Map?;
  if (values != null) {
    values.forEach((key, value) {
      UserPersonalInfoModel user = UserPersonalInfoModel.fromMap(value);
      bool isBuyer = user.buyer ?? false;
      bool isSeller = user.seller ?? false;

      if (isBuyer && isSeller) {
        bothCount++;
      } else if (isBuyer) {
        buyerCount++;
      } else if (isSeller) {
        sellerCount++;
      }

      // Check if the user was created in the current month
      DateTime currentDate = DateTime.now();
      List<String> accountDateParts =
          (user.accountCreatedDate ?? "").split('/');
      if (accountDateParts.length == 3) {
        int day = int.tryParse(accountDateParts[0]) ?? 0;
        int month = int.tryParse(accountDateParts[1]) ?? 0;
        int year = int.tryParse(accountDateParts[2]) ?? 0;
        DateTime accountDate = DateTime(year, month, day);

        if (currentDate.year == accountDate.year &&
            currentDate.month == accountDate.month) {
          currentMonthUserCount++;
          print(currentMonthUserCount);
        }
      }
    });
  }

  return {
    'buyer': buyerCount,
    'seller': sellerCount,
    'both': bothCount,
    'currentMonthUsers': currentMonthUserCount,
  };
}
