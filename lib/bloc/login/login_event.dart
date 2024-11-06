part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginButtonPressed({required this.email, required this.password, required this.context});
}

class LogOutEvent extends LoginEvent {}