import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';

class ShowHideMenuItems extends StatefulWidget {
  const ShowHideMenuItems({
    super.key,
    required this.menuItems,
    required this.selectedItems,
    required this.updateSelectedItems,
  });

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
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Items'),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
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
