import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_test/src/views/widgets/show_alert.dart';

Future<void> showExceptionDialog(
  BuildContext context, {
  required Exception exception,
  required String title,
}) {
  return showAlertDialog(
    context,
    title: title,
    content: _message(exception),
    defaultActionString: 'OK',
  );
}
String? _message(Exception exception){
  if(exception is FirebaseAuthException){return exception.message.toString();}
  else {
    return exception.toString();
  }
}