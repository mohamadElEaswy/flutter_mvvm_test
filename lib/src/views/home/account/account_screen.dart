import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_test/src/services/sqflite_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/auth.dart';
import '../../../services/cache_helper.dart';
import '../../widgets/show_alert.dart';
import 'avatar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      SQLHelper.deleteDB();
      CacheHelper.removeAllData();
      await auth.signOut();
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> _confirmSignOut({required BuildContext context}) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionString: 'ok',
        cancelActionText: 'cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
      // print('ok');
    } else {
      // print('cancel');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context: context),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: _buildUserInfo(auth.currentUser!),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (auth.currentUser!.email != null)
                Text(
                  'user email: ${auth.currentUser!.email!}',
                  style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                ),
              if (CacheHelper.getData(key: 'name').isNotEmpty)
                Text(
                  'user name: ${CacheHelper.getData(key: 'name')}',
                  style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          radius: 50.0,
          photoUrl: user.photoURL,
        ),
        const SizedBox(height: 8.0),
        if (user.email != null)
          Text(
            user.email!,
            style: const TextStyle(color: Colors.black87, fontSize: 16.0),
          ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
