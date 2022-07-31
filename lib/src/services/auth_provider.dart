// import 'package:flutter/material.dart';
// import 'package:timetracker/services/auth.dart';
//
// class AuthProvider extends InheritedWidget{
//    const AuthProvider({Key? key, required this.auth, required this.child}) : super(key: key, child: child);
//   final AuthBase auth;
//   final Widget child;
//
//
//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => false;
//
//   //final auth = AuthProvider.of(context);
//   static AuthBase? of(BuildContext context){
//     AuthProvider? provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     return provider!.auth;
//   }
// }