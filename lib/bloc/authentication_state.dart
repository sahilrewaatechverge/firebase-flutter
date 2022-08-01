import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
class Authenticated extends AuthenticationState{
  @override
  List<Object?> get props => [];

}
class UnAuthenticated extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthError extends AuthenticationState{
  final String error;
  AuthError(this.error);
  @override
  List<Object?> get props => [error];

}
