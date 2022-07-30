class Diet {
  final String? date;
  final String? totalBurned;
  final String? totalWater;
  final String? totalCalories;
  final String? totalCarbo;
  final String? totalProtein;
  final String? totalFats;
  final Map<String, dynamic>? meal;

  Diet(
      {this.date,
      this.totalBurned,
      this.totalWater,
      this.meal,
      this.totalCalories,
      this.totalCarbo,
      this.totalProtein,
      this.totalFats});

  factory Diet.fromFirestore(Map<String, dynamic>? json) => Diet(
        date: json?["date"],
        totalBurned: json?["totalBurned"],
        totalWater: json?["totalWater"],
        totalCalories: json?["totalCalories"],
        totalCarbo: json?["totalCarbo"],
        totalFats: json?["totalFats"],
        totalProtein: json?["totalProtein"],
        meal: json?["meal"],
      );

  static Map<String, dynamic> toMap(Diet diet) => {
        "date": diet.date,
        "totalBurned": diet.totalBurned,
        "totalWater": diet.totalWater,
        "totalCalories": diet.totalCalories,
        "totalCarbo": diet.totalCarbo,
        "totalProtein": diet.totalProtein,
        "meal": diet.meal,
      };
}
