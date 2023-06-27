enum Meals { breakfast, lunch, dinner }

extension MealsExtension on Meals {
  String get mealName {
    switch (this) {
      case Meals.breakfast:
        return 'Breakfast';
      case Meals.lunch:
        return 'Lunch';
      case Meals.dinner:
        return 'Dinner';
      default:
        return '';
    }
  }

  Meals get meal {
    switch (String.fromCharCodes(toString().runes).split('.').last) {
      case 'Breakfast':
        return Meals.breakfast;
      case 'Lunch':
        return Meals.lunch;
      case 'Dinner':
        return Meals.dinner;
      default:
        return Meals.breakfast;
    }
  }
}
