import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalorieda/models/api/food_service.dart';
import 'package:kalorieda/models/database/firestore_service.dart';
import 'package:kalorieda/models/diet_model.dart';
import 'package:kalorieda/models/food_model.dart';
import 'package:intl/intl.dart';

enum DietProviderState { none, loading, error }

class DetailFoodProvider extends ChangeNotifier {
  final ApiService service = ApiService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreService firestore = FirestoreService();

  DietProviderState _state = DietProviderState.none;
  DietProviderState get state => _state;

  String _date = DateFormat('yyy-MM-dd').format(DateTime.now());
  String get date => _date;

  String _items = "";
  String get items => _items;

  Diet? _diet;
  Diet? get diet => _diet;

  changeState(DietProviderState state) {
    _state = state;
    notifyListeners();
  }

  addDetailFoods(Diet diet) {
    _diet = diet;
    notifyListeners();
  }

  changeItems(String items) {
    _items = items;
    notifyListeners();
  }

  changeDate(DateTime date) {
    _date = DateFormat('yyy-MM-dd').format(date);
    notifyListeners();
  }

  Future<void> getDietByDate(String? date) async {
    try {
      changeState(DietProviderState.loading);
      _diet = await firestore.getDiet(date);
      changeState(DietProviderState.none);
    } catch (e) {
      print('gagal $e');
      changeState(DietProviderState.error);
    }
  }

  Future<String?> addDiet(Diet myDiet) async {
    try {
      changeState(DietProviderState.loading);
      User? user = auth.currentUser;
      if (user != null) {
        await getDietByDate(myDiet.date);
        if (_diet == null) {
          await firestore.addDiet(user, myDiet);
          await getDietByDate(myDiet.date);
          changeState(DietProviderState.none);
          return 'Success';
        } else {
          String key = myDiet.meal!.keys.elementAt(0);
          List value = myDiet.meal!.values.elementAt(0);
          _diet!.meal![key] = value;
          await firestore.updateDietMeal(user, _diet!);
          return 'Success';
        }
      } else {
        print('akun tidak ada');
        throw Exception('Akun tidak ditemukan');
      }
    } catch (e) {
      changeState(DietProviderState.error);
      print('erorr $e');
      return e.toString();
    }
  }

  Map<String, String> getMealMap(List<Foods>? food) {
    Map<String, String> totalMap = {};
    String foodName = '';

    for (int i = 0; i < food!.length; i++) {
      foodName = food[i].foodName!;
      totalMap['food$i'] = foodName;
    }
    return totalMap;
  }

  Map<String, double> getTotalMap(List<Foods>? food) {
    double totalCalories = 0;
    double totalCarbohydrates = 0;
    double totalFats = 0;
    double totalProtein = 0;

    for (int i = 0; i < food!.length; i++) {
      totalCalories += food[i].nfCalories;
      totalCarbohydrates += food[i].nfTotalCarbohydrate;
      totalFats += food[i].nfTotalFat;
      totalProtein += food[i].nfProtein;
    }

    final totalMap = <String, double>{
      "Calories": totalCalories,
      "Protein": totalProtein,
      "Fat": totalFats,
      "Carbohydrates": totalCarbohydrates
    };
    return totalMap;
  }

  Map<String, double> getDataMap(List<Foods>? food) {
    double totalCarbohydrates = 0;
    double totalFats = 0;
    double totalProtein = 0;

    for (int i = 0; i < food!.length; i++) {
      totalCarbohydrates += food[i].nfTotalCarbohydrate;
      totalFats += food[i].nfTotalFat;
      totalProtein += food[i].nfProtein;
    }

    final dataMap = <String, double>{
      "Protein": totalProtein * 4,
      "Fat": totalFats * 4,
      "Carbohydrates": totalCarbohydrates * 9
    };

    return dataMap;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            "BreakFast",
          ),
          value: "BreakFast"),
      const DropdownMenuItem(
          child: Text(
            "Lunch",
          ),
          value: "Lunch"),
      const DropdownMenuItem(
          child: Text(
            "Dinner",
          ),
          value: "Dinner"),
    ];
    return menuItems;
  }
}
