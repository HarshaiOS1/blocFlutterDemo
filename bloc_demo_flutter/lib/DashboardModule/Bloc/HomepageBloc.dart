import 'dart:async';
import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();
}

class HomePageLoad extends HomepageEvent {
  /*
    First Event is Page Loading
  */
  @override
  List<Object> get props => null;

}

class HomepageBloc extends Bloc<HomepageEvent, HomePageState> {
  final AuthenticationBloc authenticationBloc;

  HomepageBloc(this.authenticationBloc);

  @override
  HomePageState get initialState => HomePageLoadingState();

  @override
  Stream<HomePageState> mapEventToState(HomepageEvent event) async* {
    if (event is HomePageLoad) {
      yield HomePageLoadingState();
      try {
        //CALL API here
//        on  getting success response
      yield HomePageLoadedState();
      //if u get 401 log out
//      authenticationBloc.add(LoggedOut());
      } catch(error) {
        yield HomePageFailedState(error: error.toString());
      }
    }

    //if 401 response, logout -> Force log out in Checkout page
    authenticationBloc.add(LoggedOut());
  }

}

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageLoadingState extends HomePageState {}

class HomePageLoadedState extends HomePageState {}

class HomePageFailedState extends HomePageState {
  final String error;

  const HomePageFailedState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Home Page Failed to Load { error: $error }';
}