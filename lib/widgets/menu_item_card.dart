import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';
import '../utils/meal_utils.dart';
import 'add_edit_meal.dart';
import 'delete_meal.dart';

class MenuItemCard extends StatefulWidget {
  const MenuItemCard({
    required this.meal,
    required this.menuItems,
    required this.onRefresh,
    super.key,
  });
  final Meals meal;
  final List<MenuItem> menuItems;
  final VoidCallback onRefresh;

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  @override
  Widget build(BuildContext context) {
    return widget.menuItems.isEmpty
        ? Center(
            child: Text(
              'Add items to you ${widget.meal.mealName} menu!',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.menuItems.length,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(
                  top: 15, left: 20.0, right: 20.0, bottom: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                onTap: () => onEditPressed(
                  widget.meal,
                  widget.menuItems[index],
                  widget.onRefresh,
                ),
                onLongPress: () => onDeletePressed(
                  widget.menuItems[index],
                  widget.onRefresh,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: Text(
                      widget.menuItems[index].itemName[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  widget.menuItems[index].itemName,
                ),
                subtitle: Text(
                  widget.menuItems[index].itemDescription,
                ),
                tileColor: Colors.lightGreen[200],
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => onEditPressed(
                        widget.meal,
                        widget.menuItems[index],
                        widget.onRefresh,
                      ),
                      icon: const Icon(Icons.edit, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () => onDeletePressed(
                        widget.menuItems[index],
                        widget.onRefresh,
                      ),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void onEditPressed(Meals meal, MenuItem menuItem, VoidCallback onRefresh) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AddEditMeal(
        meal: meal,
        menuItem: menuItem,
        onRefresh: onRefresh,
      ),
    );
  }

  void onDeletePressed(MenuItem menuItem, VoidCallback onRefresh) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteMeal(
          menuItem: menuItem,
          onRefresh: onRefresh,
        );
      },
    );
  }
}
