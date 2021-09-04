import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';
import 'presentation/pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new BlocProvider<LoginBloc>(
      create: (_) => new LoginBloc(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new LoginPage(),
      ),
    );
  }
}
