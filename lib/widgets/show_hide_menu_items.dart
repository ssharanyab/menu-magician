import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';

class ShowHideMenuItems extends StatefulWidget {
  const ShowHideMenuItems({
    super.key,
    required this.menuItems,
  });

  final List<MenuItem>? menuItems;

  @override
  State<ShowHideMenuItems> createState() => _ShowHideMenuItemsState();
}

class _ShowHideMenuItemsState extends State<ShowHideMenuItems> {
  List<MenuItem> items = [];

  @override
  void initState() {
    super.initState();
    items = widget.menuItems ?? [];
  }

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Items'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(items.length, (index) {
            final item = items[index];
            final isSelected = selectedItems.contains(item.itemName);
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
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedItems);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
