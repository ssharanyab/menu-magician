import 'package:flutter/material.dart';
import 'package:menu_magician/services/database_helper.dart';

import '../utils/meal_utils.dart';
import '../widgets/add_edit_meal.dart';
import '../widgets/tab_bar_icon.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => _onTabChanged(_tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    _tabController.animateTo(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refreshMenu() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Menu Page'),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 2.0,
            indicatorColor: Colors.black,
            onTap: (index) => _onTabChanged(index),
            tabs: [
              Tab(
                child: TabBarIcon(
                  icon: Icons.coffee_rounded,
                  label: Meals.breakfast.mealName,
                ),
              ),
              Tab(
                child: TabBarIcon(
                  icon: Icons.ramen_dining,
                  label: Meals.lunch.mealName,
                ),
              ),
              Tab(
                child: TabBarIcon(
                  icon: Icons.fastfood,
                  label: Meals.dinner.mealName,
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0 && _tabController.index > 0) {
              _onTabChanged(_tabController.index - 1);
            } else if (details.primaryVelocity! < 0 &&
                _tabController.index < 2) {
              _onTabChanged(_tabController.index + 1);
            }
          },
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder(
                  future: DatabaseHelper.getMenuItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              useSafeArea: true,
                              builder: (context) => AddEditMeal(
                                meal: Meals.values[_selectedIndex],
                                menuItem: snapshot.data![index],
                                onRefresh: _refreshMenu,
                              ),
                            );
                          },
                          onLongPress: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Delete ${snapshot.data![index].itemName}?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await DatabaseHelper.deleteMenuItem(
                                                snapshot.data![index]);
                                            setState(() {
                                              snapshot.data!.removeAt(index);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                    ],
                                  );
                                });
                          },
                          title: Text(snapshot.data![index].itemName),
                          subtitle: Text(snapshot.data![index].itemDescription),
                          trailing: Text(snapshot.data![index].meal.toString()),
                        ),
                      );
                    }
                    return const Center(
                      child: Text('Breakfast'),
                    );
                  }),
              Center(
                child: Text('Lunch'),
              ),
              Center(
                child: Text('Dinner'),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (context) => AddEditMeal(
                  meal: Meals.values[_selectedIndex],
                  onRefresh: _refreshMenu,
                ),
              );
            },
            elevation: 0,
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            backgroundColor: Colors.lightGreen,
            splashColor: Colors.lightGreen[300],
            child: const Icon(Icons.add),
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
