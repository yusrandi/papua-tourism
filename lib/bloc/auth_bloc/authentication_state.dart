part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthGetFailureState extends AuthenticationState {
  final String error;

  AuthGetFailureState({this.error});
}

class AuthGetSuccess extends AuthenticationState {
  final UserModel user;
  AuthGetSuccess({this.user});
}

class AuthLoggedInState extends AuthenticationState {}

class AuthLoggedOutState extends AuthenticationState {}

class AuthLoadingState extends AuthenticationState {}
