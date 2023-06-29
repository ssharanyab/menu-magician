import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget page;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      style: ListTileStyle.drawer,
      tileColor: Colors.lightGreen[200],
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
      dense: false,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      horizontalTitleGap: 10.0,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder: (context, animation1, animation2, child) =>
                SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation1),
                    child: child),
            pageBuilder: (context, animation1, animation2) => page,
          ),
        );
      },
    );
  }
}
