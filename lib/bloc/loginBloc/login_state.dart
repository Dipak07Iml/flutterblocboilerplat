//by Dipak07Iml
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final String type;
  final String device_token;
  final String device_type;
  final bool isAuthenticated;
  final String authenticationError;
  final bool isPasswordVisible;
  final bool isAllowValidate;

  LoginState({
    this.email,
    this.password,
    this.type,
    this.device_token,
    this.device_type,
    this.isAuthenticated,
    this.isPasswordVisible = true,
    this.authenticationError,
    this.isAllowValidate = true,
  });

  @override
  List<Object> get props => [
    email,
    password,
    type,
    device_token,
    device_type,
    isAuthenticated,
    isPasswordVisible,
    authenticationError,
  ];

  LoginState copyWith({
    String email,
    String password,
    String type,
    String device_token,
    bool isAuthenticated,
    String authenticationError,
    bool isPasswordVisible,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      device_token: device_token ?? this.device_token,
      device_type: device_type ?? this.device_type,
      isAuthenticated: false ?? this.isAuthenticated,
      authenticationError: authenticationError ?? this.authenticationError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  LoginState reset() {
    return LoginState(
      email: "",
      password: "",
      type: "",
      device_token: "",
      device_type: "",
      isAuthenticated: false,
      authenticationError: "",
      isPasswordVisible: true,
      isAllowValidate: false,
    );
  }
}
