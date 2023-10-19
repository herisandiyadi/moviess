import 'package:about/about.dart';
import 'package:core/presentation/pages/homepage.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  Widget buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/circle-g.png',
            ),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('herisandiyadi@gmail.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Content'),
          onTap: toggle,
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist'),
          onTap: () async {
            toggle();
            Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
          },
        ),
        ListTile(
          onTap: () {
            toggle();
            Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: toggle,
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              double slide = 255.0 * _animationController.value;
              double scale = 1 - (_animationController.value * 0.3);
              return Stack(
                children: [
                  buildDrawer(),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: const Homepage(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
