import 'package:flutter/material.dart';
import 'package:kalorieda/models/database/firestore_service.dart';
import 'package:kalorieda/models/diet_model.dart';
import 'package:kalorieda/screens/dashboard/home_screen.dart';
import 'package:kalorieda/screens/dashboard/profile_screen.dart';
import 'package:kalorieda/screens/dashboard/search_food_screen.dart';
import 'package:intl/intl.dart';

enum HomeProviderState { none, loading, error }

class HomeProvider extends ChangeNotifier {
  final FirestoreService firestore = FirestoreService();
  final List<Widget> _screen = [const HomeScreen(), const SearchFoodScreen(), const ProfileScreen()];
  final List _waterData = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  final HomeProviderState _state = HomeProviderState.none;

  HomeProviderState get state => _state;

  double _totalCalorie = 0;
  double get totalCalorie => _totalCalorie;

  double _totalCarbo = 0;
  double get totalCarbo => _totalCarbo;

  double _totalProtein = 0;
  double get totalProtein => _totalProtein;

  double _totalFat = 0;
  double get totalFat => _totalFat;

  int _calorieleft = 2623;
  int get calorieLeft => _calorieleft;

  Diet? _diet;
  Diet? get diet => _diet;

  String? _dateTime;
  String? get dateTime => _dateTime;

  int get currentTab => _currentTab;
  List<Widget> get screen => _screen;

  int _currentTab = 0;
  int _waterTotal = 0;

  int get waterTotal => _waterTotal;
  List get waterData => _waterData;

  setTotalCarbo(String carbo) {
    _totalCarbo += double.parse(carbo);
    notifyListeners();
  }

  setTotalProtein(String protein) {
    _totalProtein += double.parse(protein);
    notifyListeners();
  }

  setTotalFat(String fat) {
    _totalFat += double.parse(fat);
    notifyListeners();
  }

  setTotalCalorie(String calorie) {
    _totalCalorie += double.parse(calorie);
    _calorieleft -= _totalCalorie.toInt();
    notifyListeners();
  }

  setDateTime(DateTime date) {
    _dateTime = DateFormat('yyy-MM-dd').format(date);
    notifyListeners();
  }

  set currentTab(int tab) {
    _currentTab = tab;
    notifyListeners();
  }

  setWaterFill(int index) {
    if (_waterData[index] == 1.0) {
      _waterData[index] = 0.3;
      _waterTotal = _waterTotal + 300;
      notifyListeners();
    }
  }

  setWaterEmpty(int index) {
    if (_waterTotal > 0 && _waterData[index] == 0.3) {
      _waterData[index] = 1.0;
      _waterTotal = _waterTotal - 300;
      notifyListeners();
    }
  }

  Future<void> getDietByDate(String? date) async {
    try {
      _diet = await firestore.getDiet(date);
    } catch (e) {
      print('gagal $e');
    }
  }
}
