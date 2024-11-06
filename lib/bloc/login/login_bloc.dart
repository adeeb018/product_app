import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:product_app/utils/exceptions/validation_exceptions.dart';

import '../../data/auth_repository.dart';
import '../../utils/auth_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        // validate email
        Validator.validateEmail(event.email);
        // validate password
        Validator.validatePassword(event.password);

        await authRepository.login(event.email, event.password, event.context);
        emit(LoginSuccess());
      } on ValidationException catch (e) {
        emit(BadEmailOrPasswordState(message: e.toString()));
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    on<LogOutEvent>((event, emit) => authRepository.logout());
  }
}
