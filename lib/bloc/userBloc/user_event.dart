//by Dipak07Iml
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends UserEvent {
  final String type;
  final String email;
  final String password;
  final String device_type;
  final String device_token;

  UserLogin(
      {this.email,
        this.password,
        this.type,
        this.device_type,
        this.device_token});

  @override
  List<Object> get props => [email, password, type, device_type, device_token];
}

class ChangePassword extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePassword({this.oldPassword, this.newPassword, this.confirmPassword});

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];
}

class FetchUserDetails extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateProfile extends UserEvent {
  final String name;
  final String phone;
  final String email;
  final String company_name;
  final File image;

  UpdateProfile(
      {this.name, this.phone, this.email, this.company_name, this.image});

  @override
  List<Object> get props => [name, phone, email, company_name, image];
}
class UserForgotPassword extends UserEvent {
  final String email;
  UserForgotPassword({
    this.email,
  });
  @override
  List<Object> get props => [email];
}


class UserAddCompany extends UserEvent {
  final String name;
  UserAddCompany({
    this.name,
  });
  @override
  List<Object> get props => [name];
}

class UserUpdateCompany extends UserEvent {
  final String name;
  final String company_id;
  UserUpdateCompany({
    this.company_id,
    this.name,
  });
  @override
  List<Object> get props => [company_id, name];
}

class FetchUserAddCompany extends UserEvent {
  @override
  List<Object> get props => [];
}

class FetchUserType extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserAddDesign extends UserEvent {
  final String design_id;
  final String company_id;
  final String size_id;
  final File image;
  final String name;
  final String variation_a;
  final String variation_b;
  final String variation_c;
  final String variation_d;
  UserAddDesign({
    this.design_id,
    this.company_id,
    this.size_id,
    this.image,
    this.name,
    this.variation_a,
    this.variation_b,
    this.variation_c,
    this.variation_d,
  });
  @override
  List<Object> get props => [
    design_id,
    company_id,
    size_id,
    image,
    name,
    variation_a,
    variation_b,
    variation_c,
    variation_d,
  ];
}

class FetchUserAddDesign extends UserEvent {
  @override
  List<Object> get props => [];
}

class FetchUserAddDesignDetail extends UserEvent {
  final String name;
  FetchUserAddDesignDetail({this.name});
  @override
  List<Object> get props => [name];
}

class UserAddSize extends UserEvent {
  final String company_id;
  final String type_id;
  final String height;
  final String width;
  UserAddSize({
    this.company_id,
    this.type_id,
    this.height,
    this.width,
  });
  @override
  List<Object> get props => [company_id, type_id, height, width];
}

class FetchUserAddSize extends UserEvent {
  final String company_id;
  FetchUserAddSize({this.company_id});
  @override
  List<Object> get props => [company_id];
}

class UserAddRetailer extends UserEvent {
  final String name;
  final String email;
  final String password;
  final String retailer_design;
  final File photo;

  UserAddRetailer({
    this.name,
    this.email,
    this.password,
    this.retailer_design,
    this.photo,
  });
  @override
  List<Object> get props => [name, email, password, retailer_design, photo];
}

class UserEditRetailer extends UserEvent {
  final String name;
  final String email;
  final String password;
  final String retailer_design;
  final File photo;
  final String retailer_id;

  UserEditRetailer(
      {this.name,
        this.email,
        this.password,
        this.retailer_design,
        this.photo,
        this.retailer_id});
  @override
  List<Object> get props =>
      [name, email, password, retailer_design, photo, retailer_id];
}

class WholesellerParchaseAddOrder extends UserEvent {
  final String retailer_id;
  final String design_id;
  final String variation_a;
  final String variation_b;
  final String variation_c;
  final String variation_d;
  WholesellerParchaseAddOrder(
      {this.retailer_id,
        this.design_id,
        this.variation_a,
        this.variation_b,
        this.variation_c,
        this.variation_d});
  @override
  List<Object> get props => [
    retailer_id,
    design_id,
    variation_a,
    variation_b,
    variation_c,
    variation_d
  ];
}

class WholesellerSellesAddOrder extends UserEvent {
  final String retailer_id;
  final String design_id;
  final String variation_a;
  final String variation_b;
  final String variation_c;
  final String variation_d;
  WholesellerSellesAddOrder(
      {this.retailer_id,
        this.design_id,
        this.variation_a,
        this.variation_b,
        this.variation_c,
        this.variation_d});
  @override
  List<Object> get props => [
    retailer_id,
    design_id,
    variation_a,
    variation_b,
    variation_c,
    variation_d
  ];
}

class ForgotPassword extends UserEvent {
  final String current_password;
  final String password;
  ForgotPassword({this.current_password, this.password});
  List<Object> get props => [current_password, password];
}

class FetchUserAddRetailer extends UserEvent {
  @override
  List<Object> get props => [];
}

class CheckUserAuthentication extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserLogOut extends UserEvent {}
