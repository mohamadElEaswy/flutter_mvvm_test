import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_test/src/services/cache_helper.dart';
import 'package:provider/provider.dart';

import 'src/services/auth.dart';
import 'src/views/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.app();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (BuildContext context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.grey[600],
        ),
        home: const LandingPage(),
      ),
    );
  }
}