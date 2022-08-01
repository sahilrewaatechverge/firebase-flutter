import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final String smsCode;
  final BuildContext context;

  VerifyWithPhone({required this.phone, required this.smsCode, required this.context});
}

class SingUpRequest extends AuthenticationEvent {
  final String email;
  final String password;

  SingUpRequest({required this.email, required this.password});
}
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class GoogleSignInRequested extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent {}
