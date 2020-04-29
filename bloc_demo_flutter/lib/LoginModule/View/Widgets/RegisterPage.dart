import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/RegistrationBloc.dart';
import 'package:blocdemoflutter/Resources/UserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../RegistrationViewController.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
    : assert(userRepository != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegistrationForm(),
      ),
    );
  }
}