import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page_bloc/bloc/login/login_bloc.dart';
import 'package:login_page_bloc/bloc/login/login_event.dart';
import 'package:login_page_bloc/bloc/login/login_state.dart';
import 'package:login_page_bloc/constants/app_text_styles.dart';
import 'package:login_page_bloc/presentation/global/outline_button.dart';
import 'package:login_page_bloc/presentation/global/text_field.dart';

import 'success_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    BlocProvider.of<LoginBloc>(context).dispose();
    super.dispose();
  }

  void handleListener(BuildContext context, LoginState state) {
    if (state is LoginErrorState) {
      Fluttertoast.showToast(
          msg: state.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (state is LoginSuccessState) {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) => new SuccessPage()));
    }
  }

  bool areValidInputs(usernameSnapshot, passwordSnapshot) {
    return (!usernameSnapshot.hasError &&
        !passwordSnapshot.hasError &&
        passwordSnapshot.hasData);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final loginBloc = BlocProvider.of<LoginBloc>(context);
    print("LOGIN MAIN BUILD");
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: [
            new ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: new Radius.circular(25),
                  topRight: new Radius.circular(25)),
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                color: Color(0xfff2f2f2),
                child: new BlocConsumer<LoginBloc, LoginState>(
                    listenWhen: (oldState, newState) =>
                        newState is LoginErrorState ||
                        newState is LoginSuccessState,
                    listener: handleListener,
                    builder: (_, state) {
                      print("LOGIN  SUCCES OR ERROR BUILD");

                      return new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          new Text("Sign In",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.boldSize25),
                          new StreamBuilder<String>(
                              stream: loginBloc.usernameStream,
                              builder: (context, snapshot) {
                                print("USERNAME BUILD");

                                return new CustomInputField(
                                    errorText: snapshot.error != null
                                        ? snapshot.error.toString()
                                        : null,
                                    controller: _usernameController,
                                    hintText: "Username",
                                    onChange: loginBloc.usernameChanged);
                              }),
                          new StreamBuilder<String>(
                              stream: loginBloc.passwordStream,
                              builder: (context, snapshot) {
                                print("PASSWORD BUILD");

                                return new CustomInputField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    hintText: "Password",
                                    errorText: snapshot.error != null
                                        ? snapshot.error.toString()
                                        : null,
                                    onChange: loginBloc.passwordChanged);
                              }),
                          new Align(
                              alignment: Alignment.centerRight,
                              child: new TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  child: new Text("Forgot Password"))),
                          state is LoginLoadingState
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new CircularProgressIndicator(),
                                  ],
                                )
                              : new StreamBuilder<String>(
                                  stream: loginBloc.usernameStream,
                                  builder: (_, usernameSnapshot) {
                                    return Container(
                                      child: new StreamBuilder<String>(
                                        stream: loginBloc.passwordStream,
                                        builder: (_, passwordSnapshot) {
                                          print("BUTTON IS BUILT");
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 32),
                                            child: new CustomOutlinedButton(
                                                bgColor: areValidInputs(
                                                        usernameSnapshot,
                                                        passwordSnapshot)
                                                    ? const Color(0xff9450e7)
                                                    : Colors.grey,
                                                onPressed: areValidInputs(
                                                        usernameSnapshot,
                                                        passwordSnapshot)
                                                    ? () {
                                                        String userName =
                                                            _usernameController
                                                                .text
                                                                .trim();
                                                        String password =
                                                            _passwordController
                                                                .text
                                                                .trim();

                                                        loginBloc.add(
                                                            new LoginClickEvent(
                                                                userName,
                                                                password));
                                                      }
                                                    : null,
                                                text: "Sign In"),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                          new Container(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: new TextButton(
                              style: TextButton.styleFrom(),
                              onPressed: () {},
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text("Are you new ?",
                                      style:
                                          new TextStyle(color: Colors.black87)),
                                  new SizedBox(width: 10),
                                  new Text("Sign Up",
                                      style: new TextStyle(
                                          color: const Color(0xff9450e7))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
