import 'package:flutter/material.dart';

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

  IconData get mealIcon {
    switch (this) {
      case Meals.breakfast:
        return Icons.coffee_rounded;
      case Meals.lunch:
        return Icons.ramen_dining;
      case Meals.dinner:
        return Icons.fastfood;
      default:
        return Icons.eco;
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

// function to get the meal from the time
Meals getMealFromTime() {
  final now = DateTime.now();
  if (now.hour < 12) {
    return Meals.breakfast;
  } else if (now.hour < 15) {
    return Meals.lunch;
  } else {
    return Meals.dinner;
  }
}
