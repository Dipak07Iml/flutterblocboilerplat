//by Dipak07Iml
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginTypeChanged extends LoginEvent {
  const LoginTypeChanged(this.type);
  final String type;
  @override
  List<Object> get props => [type];
}
class LoginDeviceTokenChanged extends LoginEvent {
  const LoginDeviceTokenChanged(this.device_token);
  final String device_token;
  @override
  List<Object> get props => [device_token];
}


class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginPasswordVisiblity extends LoginEvent {
  final bool isVisible;
  LoginPasswordVisiblity({ this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}


class ResetLogin extends LoginEvent {
  const ResetLogin();
}

class ForgotPasswordSubmitted extends LoginEvent {
  const ForgotPasswordSubmitted();
}
