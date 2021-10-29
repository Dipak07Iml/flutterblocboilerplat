//by Dipak07Iml


import 'package:flutterblocboilerplat/bloc/userBloc/user.dart';

class User {
  final int id;
  final String first_name;
  final String name;
  final String last_name;
  final String email;
  final String photo;
  final String phone;
  final int status;
  final String company_name;
  final String wholeseller_id;
  final UserType type;
  final int is_notification;
  String version;

  User({
    this.id,
    this.name,
    this.first_name,
    this.last_name,
    this.email,
    this.photo,
    this.phone = '',
    this.status,
    this.company_name = '',
    this.wholeseller_id,
    this.type,
    this.is_notification,
    this.version = '',
  });

  factory User.fromJson(Map<String, dynamic> json, int type) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? '',
      company_name: json['company_name'] ?? '',
      wholeseller_id: json['wholeseller_id'] == null
          ? ''
          : json['wholeseller_id'].toString(),
      type: type == 1 ? UserType.WHOLESELLER : UserType.RETAIL,
      is_notification: json["is_notification"],
      version: json['version'] ?? null,
    );
  }
}
