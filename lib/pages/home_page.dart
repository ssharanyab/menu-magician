import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:menu_magician/pages/menu_page.dart';
import 'package:menu_magician/pages/spin_page.dart';

import '../widgets/carousal_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text(
                'Menu Magician',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Menu'),
              onTap: () {
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
                        const MenuPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        child: CarousalButton(
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
                            );
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
                          child: CarousalButton(
                            label: 'Spin Now!',
                            icon: Icons.gamepad,
                            onPressed: () {
                              //TODO: Remove this print statement (for debugging purposes only

                              Navigator.push(
                                context,
                                PageRouteBuilder(
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
                              );
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
              height: 20.0,
            ),
            const Text(
              'Today on your plate:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Breakfast: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Lunch: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Dinner: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarousalCard extends StatelessWidget {
  const CarousalCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
