import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kalorieda/models/diet_model.dart';
import 'package:kalorieda/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add user data
  Future<void> addUser(User user, MyUser myUser) {
    return _db.collection('user').doc(user.uid).set(MyUser.toMap(myUser));
  }

  /// Update user data
  Future<void> updateUser(String name, String email, String phone, User user) {
    return _db.collection('user').doc(user.uid).update({'name': name, 'email': email, 'phone': phone});
  }

  /// Diet

  /// Get Diet user data
  Future<Diet?> getDiet(String? date) async {
    print('date $date');
    final result =
        await _db.collection('user').doc(FirebaseAuth.instance.currentUser?.uid).collection('diet').doc(date).get();
    print(result.data());
    if (result.data() != null) {
      print('result : ${result.data()}');
      final diet = Diet.fromFirestore(result.data());
      return diet;
    }
    return null;
  }

  /// Add Diet user data
  Future<void> addDiet(User user, Diet diet) async {
    _db.collection('user').doc(user.uid).collection('diet').doc(diet.date).set(Diet.toMap(diet));
  }

  /// Update Diet user data
  Future<void> updateDietMeal(User user, Diet diet) async {
    _db.collection('user').doc(user.uid).collection('diet').doc(diet.date).update({'meal': diet.meal});
  }
}
