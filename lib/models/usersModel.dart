class UserModel {
  String status;
  String message;
  List<UserData> data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      data: List<UserData>.from(
        json['data'].map((userData) => UserData.fromJson(userData)),
      ),
    );
  }
}

class UserData {
  String phoneNumber;
  num? balance; 
  String created;

  UserData({
    required this.phoneNumber,
    this.balance,
    required this.created,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      phoneNumber: json['phoneNumber'],
      balance: json['balance'] ?? null, 
      created: json['created'],
    );
  }
}