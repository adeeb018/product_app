part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class BadEmailOrPasswordState extends LoginState {
  final String message;

  BadEmailOrPasswordState({required this.message});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
