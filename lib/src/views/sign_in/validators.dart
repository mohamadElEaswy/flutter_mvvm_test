abstract class StringValidator {
  bool isValid(String value);
}

class NotEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidation {
  final NotEmptyStringValidator emailValidator = NotEmptyStringValidator();
  final NotEmptyStringValidator passwordValidator = NotEmptyStringValidator();
  final NotEmptyStringValidator phoneValidator = NotEmptyStringValidator();
  final NotEmptyStringValidator nameValidator = NotEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPhoneErrorText = 'Phone can\'t be empty';
  final String invalidNameErrorText = 'name can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
