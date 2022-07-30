class Food {
  List<Foods>? foods;

  Food({this.foods});

  Food.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Foods {
  String? foodName;
  String? brandName;
  dynamic servingQty;
  String? servingUnit;
  dynamic servingWeightGrams;
  dynamic nfCalories;
  dynamic nfTotalFat;
  dynamic nfSaturatedFat;
  dynamic nfCholesterol;
  dynamic nfSodium;
  dynamic nfTotalCarbohydrate;
  dynamic nfDietaryFiber;
  dynamic nfSugars;
  dynamic nfProtein;
  dynamic nfPotassium;
  dynamic nfP;
  dynamic source;
  dynamic ndbNo;
  Photo? photo;

  Foods(
      {this.foodName,
      this.brandName,
      this.servingQty,
      this.servingUnit,
      this.servingWeightGrams,
      this.nfCalories,
      this.nfTotalFat,
      this.nfSaturatedFat,
      this.nfCholesterol,
      this.nfSodium,
      this.nfTotalCarbohydrate,
      this.nfDietaryFiber,
      this.nfSugars,
      this.nfProtein,
      this.nfPotassium,
      this.nfP,
      this.source,
      this.ndbNo,
      this.photo});

  Foods.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    brandName = json['brand_name'];
    servingQty = json['serving_qty'];
    servingUnit = json['serving_unit'];
    servingWeightGrams = json['serving_weight_grams'];
    nfCalories = json['nf_calories'];
    nfTotalFat = json['nf_total_fat'];
    nfSaturatedFat = json['nf_saturated_fat'];
    nfCholesterol = json['nf_cholesterol'];
    nfSodium = json['nf_sodium'];
    nfTotalCarbohydrate = json['nf_total_carbohydrate'];
    nfDietaryFiber = json['nf_dietary_fiber'];
    nfSugars = json['nf_sugars'];
    nfProtein = json['nf_protein'];
    nfPotassium = json['nf_potassium'];
    nfP = json['nf_p'];
    source = json['source'];
    ndbNo = json['ndb_no'];
    photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food_name'] = foodName;
    data['brand_name'] = brandName;
    data['serving_qty'] = servingQty;
    data['serving_unit'] = servingUnit;
    data['serving_weight_grams'] = servingWeightGrams;
    data['nf_calories'] = nfCalories;
    data['nf_total_fat'] = nfTotalFat;
    data['nf_saturated_fat'] = nfSaturatedFat;
    data['nf_cholesterol'] = nfCholesterol;
    data['nf_sodium'] = nfSodium;
    data['nf_total_carbohydrate'] = nfTotalCarbohydrate;
    data['nf_dietary_fiber'] = nfDietaryFiber;
    data['nf_sugars'] = nfSugars;
    data['nf_protein'] = nfProtein;
    data['nf_potassium'] = nfPotassium;
    data['nf_p'] = nfP;
    data['source'] = source;
    data['ndb_no'] = ndbNo;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    return data;
  }
}

class Photo {
  String? thumb;
  String? highres;
  bool? isUserUploaded;

  Photo({this.thumb, this.highres, this.isUserUploaded});

  Photo.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    highres = json['highres'];
    isUserUploaded = json['is_user_uploaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumb'] = thumb;
    data['highres'] = highres;
    data['is_user_uploaded'] = isUserUploaded;
    return data;
  }
}
