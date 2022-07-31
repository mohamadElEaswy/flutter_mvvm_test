import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mvvm_test/src/model/user_model.dart';
import 'database.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authUserState();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name, String phone);
  Future<void> submitPhoneNumber({required String phoneNumber});
  Future<void> submitOTP(String otpCode);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User?> authUserState() => _firebaseAuth.authStateChanges();
  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    await firebaseFirestore!.getUserData(userCredential.user!.uid);
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await firebaseFirestore!.addUserData(
      _firebaseAuth.currentUser!.uid,
      UserModel(
        id: _firebaseAuth.currentUser!.uid,
        email: _firebaseAuth.currentUser!.email,
        name: name,
        phone: phone,
      ),
    );
    return userCredential.user;
  }

  Database? firebaseFirestore = FirestoreDatabase();
  String? userPhoneNumber;
  @override
  Future<void> submitPhoneNumber({required String phoneNumber}) async {
    userPhoneNumber = phoneNumber;
    await firebaseFirestore!
        .addUserData(
            _firebaseAuth.currentUser!.uid,
            UserModel(
              id: _firebaseAuth.currentUser!.uid,
              email: _firebaseAuth.currentUser!.email,
              name: _firebaseAuth.currentUser!.displayName,
              phone: _firebaseAuth.currentUser!.phoneNumber,
            ))
        .then((value) async => await _firebaseAuth.verifyPhoneNumber(
              phoneNumber: '+2$phoneNumber',
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
              timeout: const Duration(seconds: 40),
            ));
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print(credential.signInMethod);
    // firebaseFirestore!.addUser(
    //   uid: currentUser!.uid,
    //   email: currentUser!.email!,
    //   phoneNumber:
    //       // userCredential.user!.phoneNumber == null
    //       //     ? ''
    //       //     :
    //       currentUser!.phoneNumber ?? userPhoneNumber!,
    //   userName: currentUser!.displayName!,
    //   city: 'city',
    //   userType: 'not defined yet',
    // );

    // firebaseFirestore!.getUser(currentUser!.uid);
    currentUser!.linkWithCredential(credential);
  }

  void verificationFailed(FirebaseAuthException e) async {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  String verificationId = '';
  void codeSent(String verificationId, int? resendToken) async {
    this.verificationId == verificationId;

    //emit();
  }

  void codeAutoRetrievalTimeout(String verificationId) async {
    // print(' code auto retrieval timeout');
  }

  @override
  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    // await setUserDetails(userName);
    // await _firebaseAuth.currentUser!.updatePhoneNumber(credential);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      //emit();
    } catch (e) {
      // print(e.toString());
      //emit();
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
