import 'package:flutter/foundation.dart';
import 'package:kalorieda/models/food_model.dart';
import 'package:kalorieda/models/api/food_service.dart';

enum FoodProviderState { none, loading, error }

class FoodProvider extends ChangeNotifier {
  FoodProviderState _state = FoodProviderState.none;
  FoodProviderState get state => _state;

  List<Foods>? _foods = [];
  List<Foods>? get foods => List.unmodifiable(_foods!);

  final ApiService service = ApiService();

  addDetailFoods() {}

  changeState(FoodProviderState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getFoodBySearch(String query) async {
    changeState(FoodProviderState.loading);
    try {
      List<Foods>? foodApi = await service.getallFood(query);
      _foods = foodApi;
      changeState(FoodProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(FoodProviderState.error);
      print('error bos $e');
    }
  }
}
