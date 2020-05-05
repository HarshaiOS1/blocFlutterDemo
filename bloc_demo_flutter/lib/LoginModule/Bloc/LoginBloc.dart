import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:blocdemoflutter/Resources/UserRepository.dart';
import 'package:blocdemoflutter/LoginModule/Bloc/AuthenticationBloc.dart';
import 'package:blocdemoflutter/LoginModule/Services/LoginScreenServices.dart';
//README: Bloc dart file will contain Bloc Code, State(UI) & Event(User action)
//Login Event is Mapped to Login State by Bloc

//MARK: Login Event
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

//MARK: BLOC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        print(token.isEmpty);
        if (token.isEmpty)  {
          authenticationBloc.add(LoggedOut());
          yield LoginFailure(error: "Invalid TOKEN");
        } else {
          authenticationBloc.add(LoggedIn(token: token));
          yield LoginInitial();
        }
      } catch (error) {
        authenticationBloc.add(LoggedOut());
        yield LoginFailure(error: error.toString());
      }
    }
  }
}

//MARK: Login State

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
