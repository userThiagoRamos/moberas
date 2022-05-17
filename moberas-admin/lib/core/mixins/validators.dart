import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:mobEras/core/constants/local_keys.dart';
import 'package:quiver/strings.dart';
import 'package:string_validator/string_validator.dart';

/// Class of validation functions that the app will use
///   - This class should be used as a mixin using the `with` keyword
class Validators {
  final phoneNumberRegExp = RegExp(
      r'^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$');

  final zipCodeRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  String validateEmail(String value) {
    if (!isEmail(value.trim())) {
      return LocalKeys.invalid_email;
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if (!phoneNumberRegExp.hasMatch(value.trim())) {
      return LocalKeys.invalid_phone_number;
    }
    return null;
  }

  String validateZip(String value) {
    if (!zipCodeRegExp.hasMatch(value.trim())) {
      return LocalKeys.invalid_zip_code;
    }
    return null;
  }

  String validatePassword(String value) {
    if (isBlank(value)) {
      return LocalKeys.password_empty;
    }
    return null;
  }

  String validateFullName(String fullName) {
    if (isBlank(fullName)) {
      return LocalKeys.fullname_empty;
    }
    return null;
  }

  String validateBirthdayDay(String day) {
    if (int.tryParse(day) > 31) {
      return LocalKeys.birthday_empty;
    }
    return null;
  }

  String validateCpf(String cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Informe o cpf';
    }
    if (!CPFValidator.isValid(cpf)) {
      return 'Cpf inválido';
    }
    return null;
  }
}
