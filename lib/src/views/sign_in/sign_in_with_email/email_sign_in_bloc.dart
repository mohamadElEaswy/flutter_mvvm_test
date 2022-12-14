import 'dart:async';

import 'package:flutter_mvvm_test/src/views/sign_in/sign_in_with_email/sign_in_model.dart';

import '../../../services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  //submit button in singing in form
  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password, _model.name, _model.phone);
      }
    } catch (e) {
      updateWith(isLoading: false, submitted: false);
      rethrow;
    }
  }

// toggle between signing in forms
  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  void updatePhone(String phone) => updateWith(phone: phone);
  void updateName(String name) => updateWith(name: name);
  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
    String? phone,
    String? name,
  }) {
    //update model
    _model = _model.copyWith(
      email: email,
      password: password,
      submitted: submitted,
      isLoading: isLoading,
      formType: formType,
      phone: phone,
      name: name,
    );
    //add updated model to model controller
    _modelController.add(_model);
  }
}
