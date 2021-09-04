import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_page_bloc/bloc/login/login_event.dart';
import 'package:login_page_bloc/validators.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginClickEvent, LoginState> with Validators {
  LoginBloc() : super(new LoginInitializeState());

  final StreamController<String> _usernameController =
      new StreamController.broadcast();

  final StreamController<String> _passwordController =
      new StreamController.broadcast();

  Stream<String> get usernameStream =>
      _usernameController.stream.transform(this.usernameValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(this.passwordValidator);

  void usernameChanged(String username) {
    _usernameController.sink.add(username);
  }

  void passwordChanged(String password) {
    _passwordController.sink.add(password);
  }

  @override
  Stream<LoginState> mapEventToState(LoginClickEvent event) async* {
    yield LoginLoadingState();

    await Future.delayed(new Duration(seconds: 2));

    if (event.username == "admin" && event.password == "Admin") {
      yield LoginSuccessState();
    } else {
      yield LoginErrorState("Username or password are incorrect");
    }
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
  }
}
