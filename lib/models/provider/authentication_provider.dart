import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalorieda/models/database/firestore_service.dart';
import 'package:kalorieda/models/user_model.dart';

enum UserAuthProviderState { none, loading, error }

class AuthenticationProvider extends ChangeNotifier {
  UserAuthProviderState _state = UserAuthProviderState.none;
  UserAuthProviderState get state => _state;
  String _verificationCode = "";
  String get verificationCode => _verificationCode;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirestoreService firestore = FirestoreService();

  User? getCurrentUser() {
    User? user = firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String?> uid() async {
    return firebaseAuth.currentUser?.uid;
  }

  changeState(UserAuthProviderState state) {
    _state = state;
    notifyListeners();
  }

  changeVerificationCodeState(String verif) {
    _verificationCode = verif;
    notifyListeners();
  }

  Future<void> registerToFireStore(User? user, MyUser myUser) async {
    try {
      changeState(UserAuthProviderState.loading);
      await firestore.addUser(user!, myUser);
      changeState(UserAuthProviderState.none);
    } catch (e) {
      print('error : $e');
    }
  }

  Future<String> loginUsingPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62$phone',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verficationID, int? resendToken) {
        changeVerificationCodeState(verficationID);
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        changeVerificationCodeState(verificationID);
      },
      timeout: const Duration(seconds: 30),
    );
    return 'gagal';
  }

  Future<User?> loginUsingEmailPassword(
      {required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      changeState(UserAuthProviderState.loading);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      changeState(UserAuthProviderState.none);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
        changeState(UserAuthProviderState.error);
      }
    }
    return user;
  }

  Future<User?> registerUsingEmailPassword(
      {required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      changeState(UserAuthProviderState.loading);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      changeState(UserAuthProviderState.none);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-disable") {
        print("This email has been registered");
      } else if (e.code == "invalid-email") {
        print("This email is not valid");
      }
      changeState(UserAuthProviderState.error);
    }
    return user;
  }
}
