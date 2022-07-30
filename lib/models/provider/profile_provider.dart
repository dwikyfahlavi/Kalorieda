import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalorieda/models/database/firestore_service.dart';

enum ProfileProviderState { none, loading, error }

class ProfileProvider extends ChangeNotifier {
  ProfileProviderState _state = ProfileProviderState.none;
  ProfileProviderState get state => _state;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestore = FirestoreService();

  Future<String> updateUser(String nama, String mail, String number) async {
    try {
      changeState(ProfileProviderState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.updateUser(nama, mail, number, user);
        notifyListeners();
        changeState(ProfileProviderState.none);
        return 'Success';
      } else {
        print('akun tidak ada');
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(ProfileProviderState.error);
      print('error : $e');
      return e.toString();
    }
  }

  changeState(ProfileProviderState state) {
    _state = state;
    notifyListeners();
  }
}
