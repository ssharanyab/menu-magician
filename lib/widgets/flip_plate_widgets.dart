import 'dart:core';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:menu_magician/services/shared_preference.dart';

import '../models/menu_item_model.dart';
import '../pages/spin_page.dart';
import '../services/database_helper.dart';
import '../utils/meal_utils.dart';
import 'app_button_icon.dart';

class FlipPlate extends StatefulWidget {
  const FlipPlate({
    required this.meal,
    required this.mealIcon,
    super.key,
  });

  final Meals meal;
  final IconData mealIcon;

  @override
  State<FlipPlate> createState() => _FlipPlateState();
}

class _FlipPlateState extends State<FlipPlate> {
  String itemName = '';
  String itemDescription = '';

  bool noSelectionMade = false;

  // FlipCardController _controller = FlipCardController();
  final FlipCardController _controller = FlipCardController();

  void getData() {
    getItemId(widget.meal.mealName).then((value) {
      if (value != null) {
        setState(() {
          itemName = value.itemName ?? '';
          itemDescription = value.itemDescription ?? '';
        });
      } else {
        setState(() {
          noSelectionMade = true;
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    if (_controller.state?.isFront == false) {
      _controller.controller?.reverse();
    }
    super.initState();
  }

  Future<MenuItem?> getItemId(String meal) async {
    int? id = await SharedPreferenceService.getMenuItemId(meal);
    if (id != -1) {
      MenuItem? menuItem = await DatabaseHelper.getMenuItemById(id!);
      return menuItem;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillFront,
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT,
      flipOnTouch: true, // The side to initially display.
      onFlipDone: (isFront) {
        setState(() {
          getData();
        });
      },
      onFlip: () {
        setState(() {
          getData();
        });
      },
      controller: _controller,
      alignment: Alignment.center,
      front: FlipPlateFront(
        mealIcon: widget.mealIcon,
        meal: widget.meal,
      ),
      back: FlipPlateBack(
        itemName: itemName,
        itemDescription: itemDescription,
        noSelectionMade: noSelectionMade,
        meal: widget.meal,
        onRefresh: () {
          setState(() {
            getData();
          });
        },
      ),
    );
  }
}

class FlipPlateBack extends StatefulWidget {
  const FlipPlateBack({
    required this.itemName,
    required this.itemDescription,
    required this.noSelectionMade,
    required this.meal,
    required this.onRefresh,
    super.key,
  });

  final Meals meal;
  final String itemName;
  final String itemDescription;
  final bool noSelectionMade;
  final VoidCallback onRefresh;

  @override
  State<FlipPlateBack> createState() => _FlipPlateBackState();
}

class _FlipPlateBackState extends State<FlipPlateBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 190.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightGreen[300],
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: widget.noSelectionMade
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Spin now and find out!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    AppButtonIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionsBuilder:
                                (context, animation1, animation2, child) =>
                                    SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation1),
                                        child: child),
                            pageBuilder: (context, animation1, animation2) =>
                                SpinPage(
                              meal: widget.meal,
                            ),
                          ),
                        ).then((value) {
                          widget.onRefresh();
                        });
                      },
                      icon: Icons.rotate_left,
                      label: 'Spin',
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.itemName,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.itemDescription,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    AppButtonIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionsBuilder:
                                (context, animation1, animation2, child) =>
                                    SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation1),
                                        child: child),
                            pageBuilder: (context, animation1, animation2) =>
                                SpinPage(
                              meal: widget.meal,
                            ),
                          ),
                        ).then((value) {
                          widget.onRefresh();
                        });
                      },
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class FlipPlateFront extends StatelessWidget {
  const FlipPlateFront({
    super.key,
    required this.mealIcon,
    required this.meal,
  });

  final IconData mealIcon;
  final Meals meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 190.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightGreen[300],
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              mealIcon,
              size: 35.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              meal.mealName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
