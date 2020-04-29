import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/RegistrationBloc.dart';
import 'package:blocdemoflutter/LoginModule/View/LoginViewController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _nameController = TextEditingController();
  final _emailIdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(RegisterUserButtonPressed(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        mailID: _emailIdController.text,
        password: _password.text,
        confirmPassword: _confirmPassword.text,
        ),
      );
    }
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            )
          );
        }
        if(state is RegistedSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state){
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: _nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  controller: _phoneNumberController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email Id'),
                  controller: _emailIdController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _password,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'confirm Password'),
                  controller: _confirmPassword,
                ),
                RaisedButton(
                  onPressed: _onRegisterButtonPressed,
                  child: Text('Register'),
                ),
                Container(
                  child: state is RegisterLoading
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