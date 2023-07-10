import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_magician/pages/menu_page.dart';

import '../models/menu_item_model.dart';
import '../utils/meal_utils.dart';

class ShowHideMenuItems extends StatefulWidget {
  const ShowHideMenuItems({
    super.key,
    required this.meal,
    required this.menuItems,
    required this.selectedItems,
    required this.updateSelectedItems,
  });

  final Meals meal;
  final List<MenuItem>? menuItems;
  final List<String>? selectedItems;

  final Function(List<String>) updateSelectedItems;

  @override
  State<ShowHideMenuItems> createState() => _ShowHideMenuItemsState();
}

class _ShowHideMenuItemsState extends State<ShowHideMenuItems> {
  List<MenuItem> items = [];
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    items = widget.menuItems ?? [];
    selectedItems = widget.selectedItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Items'),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MenuPage(
                      index: widget.meal.index,
                    ),
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.lightGreen,
                semanticLabel: 'Add',
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: items.isNotEmpty
                ? Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List<Widget>.generate(items.length, (index) {
                          final item = items[index];
                          final isSelected =
                              selectedItems.contains(item.itemName);
                          return ListTile(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedItems.remove(item.itemName);
                                } else {
                                  selectedItems.add(item.itemName);
                                }
                              });
                            },
                            title: Text(item.itemName),
                            leading: isSelected
                                ? const Icon(
                                    CupertinoIcons.checkmark_alt_circle_fill,
                                    color: Colors.lightGreen,
                                  )
                                : const Icon(CupertinoIcons.circle),
                          );
                        }),
                      ),
                      if (selectedItems.length > 10)
                        const Text(
                          'Maximum of 10 items allowed',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Add items to your ${widget.meal.mealName} menu by clicking the plus icon above!',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.updateSelectedItems(selectedItems);
              Navigator.of(context).pop(selectedItems);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
