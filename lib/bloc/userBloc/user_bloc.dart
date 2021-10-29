//by Dipak07Iml
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocboilerplat/bloc/userBloc/user.dart';
import 'package:flutterblocboilerplat/models/user_model.dart';
import 'package:flutterblocboilerplat/utils/constants.dart';
import 'package:flutterblocboilerplat/utils/shared_pref.dart';
import 'user_event.dart';
import 'user_repository.dart';

enum UserType { WHOLESELLER, RETAIL, NONE }

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({this.userRepository}) : super(UserInitialState()) {
    add(CheckUserAuthentication());
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (!(event is CheckUserAuthentication)) {}
    if (event is UserLogin) {
      yield* _doLogin(event, state);
    } else if (event is CheckUserAuthentication) {
      yield* _checkAuthentication(event, state);
    } else if (event is FetchUserDetails) {
      yield* _fetchUserDetail(event, state);
    } else if (event is UpdateProfile) {
      yield* _updateProfile(event, state);
    }else if (event is UserForgotPassword) {
      yield* _mapForgotPasswordSubmittedToState(event, state);
    }   else if (event is ChangePassword) {
      yield* _changePassword(event, state);
    } else if (event is UserLogOut) {
      yield UserInitialState();
    } else if (event is ForgotPassword) {}
  }

  Stream<UserState> _doLogin(UserLogin event, UserState state) async* {
    yield UserLoggedInState(loading: false);
    final _user = await userRepository.login(
        event.email, event.password, event.type, event.device_token);
    print('===>> Response : ${_user['data']}');
    if (_user['code'] != 200) {
      yield UserAuthenticationError(
          errorMsg: _user[MESSAGE], code: _user['code']);
      yield UserLoggedInState(loading: true);
    } else {
      if (!_user[SUCCESS]) {
        yield UserLoggedInState(
            message: _user[MESSAGE], success: _user[SUCCESS], loading: true);
      } else {
        final _data = _user[DATA];
        await SharedPref.saveString(AUTH_TOKEN, _data['token']);
        await SharedPref.saveString(ID, _data['id'].toString());

        await SharedPref.saveObject(USER, _data);
        await SharedPref.saveInt(USER_TYPE, _data['type']);
        print('===>> Response Code : ${_data['type']}');
        await SharedPref.saveObject(USER, _data);
        yield UserLoggedInState(
            userType: _data['type'],
            message: _user[MESSAGE],
            success: _user[SUCCESS],
            loading: false);
      }
    }
  }

  Stream<UserState> _changePassword(
      ChangePassword event, UserState state) async* {
    final Map<String, String> _params = Map();
    _params.putIfAbsent('current_password', () => event.oldPassword);
    _params.putIfAbsent('password', () => event.newPassword);
    // _params.putIfAbsent('password_confirmation', () => event.confirmPassword);
    final _user = await userRepository.changePassword(_params);
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      add(FetchUserDetails());
      yield ChangePasswordInState(message: _user[MESSAGE]);
    }
  }

  Stream<UserState> _updateProfile(
      UpdateProfile event, UserState state) async* {
    final Map<String, dynamic> _params = Map();
    _params.putIfAbsent('email', () => event.email);
    if (event.name != null) {
      _params.putIfAbsent('name', () => event.name);
    }

    if (event.company_name != null) {
      _params.putIfAbsent('company_name', () => event.company_name);
    }
    if (event.image != null) {
      _params.putIfAbsent('photo', () => event.image);
    }
    if (event.phone != null) {
      _params.putIfAbsent('phone', () => event.phone);
    }
    final _user = await userRepository.updateProfile(_params);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    }
    final _data = _user[DATA];
    final user = User.fromJson(_data as Map<String, dynamic>, 1);
    await SharedPref.saveObject(USER, _data);
    yield UserProfileUpdatedState(currentUser: user, message: _user[MESSAGE]);
  }

  Stream<UserState> _mapForgotPasswordSubmittedToState(
      UserForgotPassword event,
      UserState state,
      ) async* {
    final Map<String, String> _params = Map();
    _params.putIfAbsent('email', () => event.email);
    final _user = await userRepository.forgotpassword(_params);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield ForgotpasswordSubmitted(message: _user[MESSAGE],loading:true);
    }
  }


  Stream<UserState> _mapAddCompanySubmittedToState(
      UserAddCompany event,
      UserState state,
      ) async* {
    final Map<String, String> _params = Map();
    _params.putIfAbsent('name', () => event.name);
    final _user = await userRepository.addcompany(_params);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      add(FetchUserDetails());
      yield AddCompanySubmitted(message: _user[MESSAGE]);
    }
  }

  Stream<UserState> _mapUpdateCompanySubmittedToState(
      UserUpdateCompany event,
      UserState state,
      ) async* {
    final Map<String, String> _params = Map();
    _params.putIfAbsent('company_id', () => event.company_id);
    _params.putIfAbsent('name', () => event.name);
    final _user = await userRepository.updatecompany(_params);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield AddCompanySubmitted(message: _user[MESSAGE]);
    }
  }

  Stream<UserState> _mapFetchCompanyToState(
      FetchUserAddCompany event,
      UserState state,
      ) async* {
    final _user = await userRepository.getcompany();
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield FetchCompanyState(company: _user[DATA] as List<dynamic>);
    }
  }

  Stream<UserState> _mapAddDesignSubmittedToState(
      UserAddDesign event,
      UserState state,
      ) async* {
    final Map<String, dynamic> _params = Map();
    if (event.design_id == "null") {
      _params.putIfAbsent('company_id', () => event.company_id);
      _params.putIfAbsent('size_id', () => event.size_id);
      _params.putIfAbsent('name', () => event.name);
      _params.putIfAbsent('variation_a', () => event.variation_a);
      _params.putIfAbsent('variation_b', () => event.variation_b);
      _params.putIfAbsent('variation_c', () => event.variation_c);
      _params.putIfAbsent('variation_d', () => event.variation_d);
      _params.putIfAbsent('image', () => event.image);
    } else {
      _params.putIfAbsent('design_id', () => event.design_id);
      _params.putIfAbsent('company_id', () => event.company_id);
      _params.putIfAbsent('size_id', () => event.size_id);
      _params.putIfAbsent('name', () => event.name);
      _params.putIfAbsent('variation_a', () => event.variation_a);
      _params.putIfAbsent('variation_b', () => event.variation_b);
      _params.putIfAbsent('variation_c', () => event.variation_c);
      _params.putIfAbsent('variation_d', () => event.variation_d);
      _params.putIfAbsent('image', () => event.image);
    }

    final _user = await userRepository.adddesign(_params);
    print('success message ${_user[SUCCESS]}');
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      if (!_user[SUCCESS]) {
        yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
      } else {
        add(FetchUserDetails());
        add(FetchUserAddDesign());
        yield AddDesignSubmitted(addDesingmessage: _user[MESSAGE]);
      }
    }
  }

  Stream<UserState> _mapFetchDesignToState(
      FetchUserAddDesign event,
      UserState state,
      ) async* {
    yield FetchDesignState(loading: false);
    final _user = await userRepository.getdesign();
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield FetchDesignState(
          design: _user[DATA] as List<dynamic>, loading: true);
    }
  }

  Stream<UserState> _mapFetchAddDesignDetailToState(
      FetchUserAddDesignDetail event,
      UserState state,
      ) async* {
    final _userdetail = await userRepository.getdesigndetail(event.name);
    if (!_userdetail[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _userdetail[MESSAGE]);
    } else {
      yield FetchDesignDetailState(
          designdetail: _userdetail[DATA] as List<dynamic>);
    }
  }

  Stream<UserState> _mapAddSizeSubmittedToState(
      UserAddSize event,
      UserState state,
      ) async* {
    final Map<String, String> _params = Map();
    _params.putIfAbsent('company_id', () => event.company_id.toString());
    _params.putIfAbsent('type_id', () => event.type_id.toString());
    _params.putIfAbsent('height', () => event.height.toString());
    _params.putIfAbsent('width', () => event.width.toString());
    final _user = await userRepository.addSize(_params);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      add(FetchUserDetails());
      yield AddSizeSubmitted(message: _user[MESSAGE]);
    }
  }

  Stream<UserState> _mapFetchTypeToState(
      FetchUserType event,
      UserState state,
      ) async* {
    final _user = await userRepository.getType();
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield FetchTypeState(typelist: _user[DATA] as List<dynamic>);
    }
  }

  Stream<UserState> _mapFetchSizeToState(
      FetchUserAddSize event,
      UserState state,
      ) async* {
    final _user = await userRepository.getSize(event.company_id);
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield FetchSizeState(sizelist: _user[DATA] as List<dynamic>);
    }
  }

  Stream<UserState> _mapAddRetailerSubmittedToState(
      UserAddRetailer event,
      UserState state,
      ) async* {

    final Map<String, dynamic> _params = Map();
    _params.putIfAbsent('photo', () => event.photo);
    _params.putIfAbsent('name', () => event.name);
    _params.putIfAbsent('email', () => event.email);
    _params.putIfAbsent('password', () => event.password);
    _params.putIfAbsent('retailer_design', () => event.retailer_design);
    final _user = await userRepository.addretailer(_params);
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      if (!_user[SUCCESS]) {
        yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
      } else {
        add(FetchUserDetails());
        yield AddRetailerSubmitted(message: _user[MESSAGE], loading: true);
      }
    }

  }

  Stream<UserState> _mapEditRetailerSubmittedToState(
      UserEditRetailer event,
      UserState state,
      ) async* {
    final Map<String, dynamic> _params = Map();
    _params.putIfAbsent('photo', () => event.photo);
    _params.putIfAbsent('name', () => event.name);
    _params.putIfAbsent('email', () => event.email);
    _params.putIfAbsent('password', () => event.password);
    _params.putIfAbsent('retailer_design', () => event.retailer_design);
    _params.putIfAbsent('retailer_id', () => event.retailer_id);
    final _user = await userRepository.editretailer(_params);
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      if (!_user[SUCCESS]) {
        yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
      } else {
        add(FetchUserDetails());
        yield EditRetailerSubmitted(message: _user[MESSAGE], loading: true);
      }
    }



  }


  Stream<UserState> _mapWholeselleraddparchaseorderSubmittedToState(
      WholesellerParchaseAddOrder event,
      UserState state,
      ) async* {
    yield AddOrderSubmitted(loading: false);

    final Map<String, String> _params = Map();
    _params.putIfAbsent('design_id', () => event.design_id);
    _params.putIfAbsent('variation_a', () => event.variation_a);
    _params.putIfAbsent('variation_b', () => event.variation_b);
    _params.putIfAbsent('variation_c', () => event.variation_c);
    _params.putIfAbsent('variation_d', () => event.variation_d);
    final _user = await userRepository.addwholselerparchaseorder(_params);
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      if (!_user[SUCCESS]) {
        yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
      } else {
        yield AddOrderSubmitted(purchasemessage: _user[MESSAGE], loading: true);
      }
    }
  }

  Stream<UserState> _mapWholeselleraddsellesorderSubmittedToState(
      WholesellerSellesAddOrder event,
      UserState state,
      ) async* {
    yield AddOrderSubmitted(loading: false);

    final Map<String, String> _params = Map();
    _params.putIfAbsent('retailer_id', () => event.retailer_id);
    _params.putIfAbsent('design_id', () => event.design_id);
    _params.putIfAbsent('variation_a', () => event.variation_a);
    _params.putIfAbsent('variation_b', () => event.variation_b);
    _params.putIfAbsent('variation_c', () => event.variation_c);
    _params.putIfAbsent('variation_d', () => event.variation_d);
    final _user = await userRepository.addwholselersellesorder(_params);
    if (_user['code'] != 200) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE], loading: true);
    } else {
      if (!_user[SUCCESS]) {
        yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
      } else {
        yield AddOrdersellesSubmitted(
            ordersellesmessage: _user[MESSAGE], loading: true);
      }
    }
  }

/*

*/

  Stream<UserState> _mapFetchRetailerToState(
      FetchUserAddRetailer event,
      UserState state,
      ) async* {
    final _user = await userRepository.getretailer();
    if (!_user[SUCCESS]) {
      yield UserAuthenticationError(errorMsg: _user[MESSAGE]);
    } else {
      yield FetchRetailerState(retailerlist: _user[DATA] as List<dynamic>);
    }
  }

  Stream<UserState> _checkAuthentication(
      CheckUserAuthentication event, UserState state) async* {
    await Future.delayed(Duration(seconds: 3));
    final UserType userType = await getUserType();
    yield UserAlreadyLoggedInState(
      userType: userType == UserType.WHOLESELLER
          ? 1
          : userType == UserType.RETAIL
          ? 2
          : 0,
    );
    add(FetchUserDetails());
  }

  Future<UserType> getUserType() async {
    final int _userType = await SharedPref.readInt(USER_TYPE);
    return _userType == 1
        ? UserType.WHOLESELLER
        : _userType == 2
        ? UserType.RETAIL
        : UserType.NONE;
  }

  Stream<UserState> _fetchUserDetail(
      FetchUserDetails event, UserState state) async* {
    yield UserDetailsState(loadinguser: false);
    final int userType = await SharedPref.readInt(USER_TYPE);
    final userData = await SharedPref.readObject(USER);
    User user;
    if (userData != null) {
      user = User.fromJson(jsonDecode(userData), userType);
    }

    if (user == null) {
      user = User(type: userType == 1 ? UserType.WHOLESELLER : UserType.RETAIL);
    }

    yield UserDetailsState(currentUser: user, loadinguser: true);
  }
}
