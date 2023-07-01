import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';
import '../services/database_helper.dart';

class DeleteMeal extends StatefulWidget {
  const DeleteMeal({
    required this.menuItem,
    required this.onRefresh,
    super.key,
  });

  final MenuItem menuItem;
  final VoidCallback onRefresh;

  @override
  State<DeleteMeal> createState() => _DeleteMealState();
}

class _DeleteMealState extends State<DeleteMeal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Are you sure you want to delete ${widget.menuItem.itemName}?'),
      actionsPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
          ),
          onPressed: () async {
            await DatabaseHelper.deleteMenuItem(widget.menuItem);
            setState(() {
              widget.onRefresh();
              Navigator.pop(context);
            });
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
