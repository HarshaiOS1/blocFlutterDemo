import 'package:blocdemoflutter/LoginModule/Bloc/LoginBloc.dart';
import 'package:blocdemoflutter/LoginModule/View/Widgets/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocdemoflutter/Resources/UserRepository.dart';
import 'package:flutter/cupertino.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepo;
  LoginForm({Key key, this.userRepo});

  @override
  State<LoginForm> createState() => _LoginFormState(this.userRepo);
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserRepository userRepository;

  _LoginFormState(this.userRepository);

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    _onRegisterButtonPressed() {
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//          RegisterPage(userRepository: userRepository)), (Route<dynamic> route) => false);

      Navigator.of(context).push(
      CupertinoPageRoute<Null>(builder: (BuildContext context){
      return RegisterPage(userRepository: userRepository);
      }));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed:
                  state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                ),
                RaisedButton(
                  onPressed: _onRegisterButtonPressed,
                  child: Text('Register New User'),
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
