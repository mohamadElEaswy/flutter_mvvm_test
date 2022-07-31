import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_test/src/views/sign_in/sign_in_with_email/sign_in_model.dart';
import 'package:provider/provider.dart';

import '../../../services/auth.dart';
import '../../widgets/exceptions.dart';
import '../../widgets/global_button.dart';
import '../../widgets/text_form_field.dart';
import 'email_sign_in_bloc.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key, required this.bloc}) : super(key: key);
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => SignInWithEmail(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await widget.bloc.submit();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // showAlertDialog(context, title: 'sign in failed', content: e.message!, defaultActionString: 'OK');

      showExceptionDialog(
        context,
        title: 'sign in failed',
        exception: e,
      );
    }
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel? model) {
    // final String primaryText = model!.formType == EmailSignInFormType.signIn
    //     ? 'Sign in'
    //     : 'Create an account';
    // final String secondaryText = model.formType == EmailSignInFormType.signIn
    //     ? 'Need an account? Register'
    //     : 'Have an account? Sign in';
    // bool submitEnabled = model.emailValidator.isValid(model.email) &&
    //     model.emailValidator.isValid(model.password) &&
    //     !model.isLoading;

    return [
      const SizedBox(height: 8),
      GlobalTextFormField(
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        hintText: 'test@test.com',
        controller: _emailController,
        lable: 'Email',
        errorText: model!.emailErrorText,
        enabled: model.isLoading == false,
        obscureText: false,
        focusNode: _emailFocusNode,
        onEditingComplete: () => _emailEditingComplete(model),
        onChanged: widget.bloc.updateEmail,
      ),
      if (model.formType == EmailSignInFormType.register)
        const SizedBox(height: 8),
      if (model.formType == EmailSignInFormType.register)
        GlobalTextFormField(
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.done,
          controller: _nameController,
          lable: 'User Name',
          errorText: model.nameErrorText,
          enabled: model.isLoading == false,
          obscureText: false,
          focusNode: _nameFocusNode,
          onEditingComplete: model.submitEnabled ? _submit : null,
          onChanged: widget.bloc.updateName,
        ),
        if (model.formType == EmailSignInFormType.register)
        const SizedBox(height: 8),
      if (model.formType == EmailSignInFormType.register)
        GlobalTextFormField(
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          controller: _phoneController,
          lable: 'Phone Number',
          errorText: model.phoneErrorText,
          enabled: model.isLoading == false,
          obscureText: false,
          focusNode: _phoneFocusNode,
          onEditingComplete: model.submitEnabled ? _submit : null,
          onChanged: widget.bloc.updatePhone,
        ),
      const SizedBox(height: 8),
      GlobalTextFormField(
        textInputType: TextInputType.number,
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        lable: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
        obscureText: true,
        focusNode: _passwordFocusNode,
        onEditingComplete: model.submitEnabled ? _submit : null,
        onChanged: widget.bloc.updatePassword,
      ),
      const SizedBox(height: 8),
      DefaultButton(
        text: model.primaryText,
        color: Colors.indigo,
        onPressed: model.submitEnabled ? _submit : null,
      ),
      // ElevatedButton(onPressed: () {}, child: const Text('Sign in')),
      const SizedBox(height: 8),
      TextButton(
          onPressed: !model.isLoading ? _toggleFormType : null,
          child: Text(model.secondaryText)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in With Email')),
      body: SingleChildScrollView(
        child: StreamBuilder<EmailSignInModel>(
            stream: widget.bloc.modelStream,
            initialData: EmailSignInModel(),
            builder: (context, snapshot) {
              EmailSignInModel? model = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buildChildren(model!),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
