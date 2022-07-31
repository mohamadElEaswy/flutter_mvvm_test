import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  const GlobalTextFormField(
      {Key? key,
      required this.controller,
      required this.lable,
      required this.errorText,
      required this.enabled,
      required this.focusNode,
      required this.onEditingComplete,
      required this.onChanged,
      required this.obscureText,
      required this.textInputAction,
      required this.textInputType,
      this.hintText,
      })
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String lable;
  final String? errorText;
  final String? hintText;
  final bool enabled;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,keyboardType: textInputType,
      decoration: InputDecoration(
        // label: Text(lable),
        labelText: lable,
        errorText: errorText,
        enabled: enabled,hintText: hintText,
      ),
      obscureText: obscureText,
      autocorrect: false,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
