import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:menu_magician/pages/menu_page.dart';
import 'package:menu_magician/pages/spin_page.dart';
import 'package:menu_magician/utils/meal_utils.dart';

import '../widgets/app_button_icon.dart';
import '../widgets/carousal_card.dart';
import '../widgets/drawer_list_tile.dart';
import '../widgets/flip_plate_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightGreen[100],
      ),
      drawer: Drawer(
        width: 250,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        shadowColor: Colors.black,
        elevation: 10.0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.lightGreen[200],
        child: ListView(
          children: [
            Container(
              height: 150,
              constraints: const BoxConstraints.expand(height: 150),
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[200],
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Menu Magician',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Your menu, your way!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/images/magician.png',
                        width: 90,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const DrawerListTile(
              title: 'Menu',
              subtitle: 'Add or edit your menu',
              icon: Icons.menu_book,
              page: MenuPage(),
            ),
            const DrawerListTile(
              title: 'Spin',
              subtitle: 'Decide your meal',
              icon: Icons.gamepad,
              page: SpinPage(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlutterCarousel(
              items: [
                // Welcome Card
                CarousalCard(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Welcome to Menu Magician!',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Can’t decide what to eat? Let the magician decide for you! ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/images/magician.png',
                            height: 160.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu Card
                CarousalCard(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Image.asset(
                                  'assets/images/plate.png',
                                  height: 150.0,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Customize your\nmenu!',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Add or Edit your favorite\nmeals to your menu!',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AppButtonIcon(
                          label: 'Menu ',
                          icon: Icons.menu_book_rounded,
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
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const MenuPage(),
                              ),
                            ).then((value) => setState(() {}));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Spin Card
                CarousalCard(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Still thinking what\nto eat?',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Spin the wheel and find \nout now!',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 20.0,
                            )
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: AppButtonIcon(
                            label: 'Spin',
                            icon: Icons.rotate_left,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  maintainState: false,
                                  transitionsBuilder: (context, animation1,
                                          animation2, child) =>
                                      SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation1),
                                          child: child),
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const SpinPage(),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                          )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/thinking_girl.png',
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 250.0,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                allowImplicitScrolling: true,
                autoPlay: true,
                autoPlayInterval: const Duration(milliseconds: 5000),
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                autoPlayCurve: Curves.easeInOutCubicEmphasized,
                enlargeCenterPage: false,
                controller: CarouselController(),
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                pauseAutoPlayInFiniteScroll: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                disableCenter: false,
                showIndicator: true,
                slideIndicator: const CircularSlideIndicator(),
                reverse: false,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              'Today on your plate:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    FlipPlate(
                      meal: Meals.breakfast,
                      mealIcon: Icons.coffee_rounded,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FlipPlate(
                      meal: Meals.lunch,
                      mealIcon: Icons.ramen_dining,
                    ),
                  ],
                ),
                const FlipPlate(
                  meal: Meals.dinner,
                  mealIcon: Icons.fastfood,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.lightGreen[200],
      //   height: 60.0,
      // ),
    );
  }
}
