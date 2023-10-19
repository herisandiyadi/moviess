import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/tv/home_tv_page.dart';

class Homepage extends StatelessWidget {
  static const routeName = '/home';

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moviess'),
          leading: const Icon(Icons.menu),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
              ),
              Tab(
                icon: Icon(Icons.tv),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [HomeMoviePage(), HomeTVPage()],
        ),
      ),
    );
  }
}
