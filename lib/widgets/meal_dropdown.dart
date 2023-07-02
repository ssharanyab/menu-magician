import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';
import '../utils/meal_utils.dart';

class MealDropDown extends StatefulWidget {
  const MealDropDown({
    Key? key,
    required this.buildEnabledBorder,
    required this.buildFocusedBorder,
    required this.meal,
    this.menuItem,
  }) : super(key: key);

  final OutlineInputBorder buildEnabledBorder;
  final OutlineInputBorder buildFocusedBorder;
  final Meals meal;
  final MenuItem? menuItem;

  @override
  State<MealDropDown> createState() => _MealDropDownState();
}

class _MealDropDownState extends State<MealDropDown> {
  late Meals _meal;

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Select a meal',
        labelStyle: const TextStyle(
          fontSize: 18.0,
        ),
        enabledBorder: widget.buildEnabledBorder,
        focusedBorder: widget.buildFocusedBorder,
      ),
      elevation: 0,
      icon: const Icon(CupertinoIcons.chevron_down),
      value: widget.menuItem != null
          ? Meals.values
              .where((element) => element.mealName == widget.menuItem!.meal)
              .first
          : _meal,
      onChanged: (value) {
        setState(() {
          _meal = value!;
        });
      },
      items: Meals.values.map((meal) {
        return DropdownMenuItem(
          value: meal,
          child: Row(
            children: [
              Icon(
                meal.mealIcon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(meal.mealName),
            ],
          ),
        );
      }).toList(),
    );
  }
}
