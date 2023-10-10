import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';

class CustomDrawerTV extends StatefulWidget {
  const CustomDrawerTV({super.key});

  @override
  State<CustomDrawerTV> createState() => _CustomDrawerTVState();
}

class _CustomDrawerTVState extends State<CustomDrawerTV>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );
  }

  Widget buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/circle-g.png',
              ),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('herisandiyadi@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv_outlined),
            title: Text('TV Show'),
            onTap: toggle,
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
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
                    child: HomeTVPage(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
