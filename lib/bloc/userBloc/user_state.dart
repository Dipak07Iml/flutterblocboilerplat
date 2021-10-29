//by Dipak07Iml
import 'package:flutterblocboilerplat/models/user_model.dart';

abstract class UserState {
  final bool isLoggedIn;
  final User user;
  final String msg;
  final bool loading;

  const UserState({this.isLoggedIn = false, this.user, this.msg, this.loading});
}

class UserInitialState extends UserState {}

class UserAuthenticationError extends UserState {
  final String errorMsg;
  final bool loading;
  final int code;

  UserAuthenticationError({this.errorMsg,this.loading, this.code});
}

class ChangePasswordInState extends UserState {
  final String message;
  final bool loading;

  ChangePasswordInState({this.message, this.loading});
}


class UserLoggedInState extends UserState {
  final String message;
  final bool loading;
  final int userType;
  final bool success;

  UserLoggedInState({
    this.message,
    this.userType,
    this.loading,
    this.success,
  });
}

class UserAlreadyLoggedInState extends UserState {
  final int userType;

  UserAlreadyLoggedInState({
    this.userType = 1,
  });

  @override
  bool get isLoggedIn => (userType == 1 || userType == 2);
}

class UserDetailsState extends UserState {
  final User currentUser;
  final bool loadinguser;
  UserDetailsState({this.currentUser, this.loadinguser});

  @override
  User get user => this.currentUser;
}

class UserProfileUpdatedState extends UserState {
  final User currentUser;
  final String message;
  UserProfileUpdatedState({this.currentUser, this.message});

  @override
  User get user => this.currentUser;
}

class AddCompanySubmitted extends UserState {
  final String message;
  AddCompanySubmitted({this.message});
}

class ForgotpasswordSubmitted extends UserState {
  final bool loading;
  final String message;
  ForgotpasswordSubmitted({this.message,this.loading});
}

class OrderConfirmSubmitted extends UserState {
  final String message;
  OrderConfirmSubmitted({this.message});
}

class FetchCompanyState extends UserState {
  final List<dynamic> company;
  FetchCompanyState({this.company});
}

class AddDesignSubmitted extends UserState {
  final String addDesingmessage;
  AddDesignSubmitted({this.addDesingmessage});
}

class FetchDesignState extends UserState {
  final bool loading;
  final List<dynamic> design;
  FetchDesignState({this.design, this.loading});
}

class FetchDesignDetailState extends UserState {
  final List<dynamic> designdetail;
  FetchDesignDetailState({this.designdetail});
}

class AddSizeSubmitted extends UserState {
  final String message;
  AddSizeSubmitted({this.message});
}

class AddOrderSubmitted extends UserState {
  final bool loading;

  final String purchasemessage;
  AddOrderSubmitted({this.purchasemessage, this.loading});
}

class AddOrdersellesSubmitted extends UserState {
  final bool loading;

  final String ordersellesmessage;
  AddOrdersellesSubmitted({this.ordersellesmessage, this.loading});
}

class FetchSizeState extends UserState {
  final List<dynamic> sizelist;
  FetchSizeState({this.sizelist});
}

class FetchTypeState extends UserState {
  final List<dynamic> typelist;
  FetchTypeState({this.typelist});
}

class AddRetailerSubmitted extends UserState {
  final String message;
  final bool loading;
  AddRetailerSubmitted({this.message,this.loading});
}

class EditRetailerSubmitted extends UserState {
  final String message;
  final bool loading;
  EditRetailerSubmitted({this.message,this.loading});
}

class FetchRetailerState extends UserState {
  final List<dynamic> retailerlist;
  FetchRetailerState({this.retailerlist});
}

class ClearState extends UserState {}
