import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'AuthenticationBloc.dart';
import 'package:blocdemoflutter/Resources/UserRepository.dart';

//MARK: Register Event
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserButtonPressed extends RegisterEvent {
  final String name;
  final String mailID;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const RegisterUserButtonPressed({
    @required this.name,
    @required this.mailID,
    @required this.phoneNumber,
    @required this.password,
    @required this.confirmPassword,
    });

  @override
  List<Object> get props => [name, mailID, phoneNumber, password, confirmPassword];

  @override
  String toString() =>
      'RegistraionButtonPressed { name: $name, mailID: $mailID, phoneNumber: $phoneNumber, password: $password, confirmpassword: $confirmPassword}';
}

//MARK: Register Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
}) : assert (authenticationBloc != null),
      assert (userRepository != null);

  RegisterState get initialState => NotRegistered();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is RegisterUserButtonPressed) {
      yield RegisterLoading();
      try {
        final token = await userRepository.registerUser(name: event.name, mailId: event.mailID,
            phoneNumber: event.phoneNumber, password: event.password, confirmPassword: event.confirmPassword);
        if (token.isEmpty) {
          yield RegisterFailure(error: "Invalid Token");
        } else {
          authenticationBloc.add(RegisterdNewUser(token: token));
          yield RegistedSuccess();
        }
      }catch (error){
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}

//MARK Register State

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];

}

class NotRegistered extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegistedSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure { error: $error }';

}
