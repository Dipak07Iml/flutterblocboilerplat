//by Dipak07Iml
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocboilerplat/bloc/userBloc/user.dart';

import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;
  LoginBloc({ this.userBloc}) : super(LoginState());


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginTypeChanged) {
      yield _mapTypeChangedToState(event, state);
    }else if (event is LoginDeviceTokenChanged) {
      yield _mapDeviceTokenChangedToState(event, state);
    } else if (event is LoginPasswordVisiblity) {
      yield _mapPasswordVisibleToState(event, state);
    } else if (event is ResetLogin) {
      print('reset state here');
      yield state.reset();
    } else if (event is LoginSubmitted) {
      yield _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
      LoginEmailChanged event,
      LoginState state,
      ) {
    return state.copyWith(email: event.email);
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event,
      LoginState state,
      ) {
    return state.copyWith(password: event.password);
  }
  LoginState _mapTypeChangedToState(
      LoginTypeChanged event,
      LoginState state,
      ) {
    return state.copyWith(type: event.type);
  }
  LoginState _mapDeviceTokenChangedToState(
      LoginDeviceTokenChanged event,
      LoginState state,
      ) {
    return state.copyWith(device_token: event.device_token);
  }


  LoginState _mapPasswordVisibleToState(
      LoginPasswordVisiblity event,
      LoginState state,
      ) {
    return state.copyWith(isPasswordVisible: !event.isVisible);
  }

  LoginState _mapLoginSubmittedToState(
      LoginSubmitted event,
      LoginState state,
      ) {
    final email = state.email;
    final password = state.password;
    final type = state.type;
    final device_token = state.device_token;
    final device_type = state.device_type;
    print('submitted value => $email and $password');

    userBloc.add(UserLogin(email: email, password: password,type:type,device_token:device_token, device_type: device_type));
    return state.copyWith();
  }



}
