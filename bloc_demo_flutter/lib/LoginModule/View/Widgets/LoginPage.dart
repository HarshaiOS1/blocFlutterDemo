import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/LoginBloc.dart';
import 'package:blocdemoflutter/Resources/UserRepository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../LoginViewController.dart';


class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(userRepo: userRepository),
      ),
    );
  }
}
