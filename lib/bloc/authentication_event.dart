import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SingInRequest extends AuthenticationEvent {
  final String email;
  final String password;

  SingInRequest({required this.email, required this.password});
}

class VerifyWithPhone extends AuthenticationEvent {
  final String phone;

  VerifyWithPhone({required this.phone});
}

class SingUpRequest extends AuthenticationEvent {
  final String email;
  final String password;

  SingUpRequest({required this.email, required this.password});
}

class GoogleSignInRequested extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent {}
