class CaloriesCalculator {
  static final averageWeight = 62.0;
  static final ratio = 1.6 * 0.0175 / 1.60934 * 60;
  double weight;

  CaloriesCalculator({this.weight});

  double calculate(double distance) {
    weight = weight == null ? averageWeight : weight;
    return ratio * weight * distance;
  }

  // Calories burned per minute = (MET x body weight in Kg x 3.5) ÷ 200
}
