import 'package:blocdemoflutter/DashboardModule/Bloc/HomepageBloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/RegistrationBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocListener<HomepageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageFailedState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<HomepageBloc, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Container(
              child: Center(
                  child: RaisedButton(
                    child: Text('logout'),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                    },
                  )),
            ),
          );
        },
      ),
    );
  }
}