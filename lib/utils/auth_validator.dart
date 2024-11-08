
import 'exceptions/validation_exceptions.dart';

class AuthValidator {

  static bool validateEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    return password.length >= 6 ;
  }
}

class Validator {
  static void validateEmail(String email) {
    if (!AuthValidator.validateEmail(email)) {
      throw ValidationException('Incorrect email format');
    }
  }

  static void validatePassword(String password) {
    if (!AuthValidator.validatePassword(password)) {
      throw ValidationException('password length must be at-least 6');
    }
  }
}