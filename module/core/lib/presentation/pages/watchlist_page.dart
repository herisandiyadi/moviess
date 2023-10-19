import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/tv/watchlist_tv_page.dart';

class WatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
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
        body: TabBarView(
          children: [
            const WatchlistMoviesPage(),
            WatchlistTvPage(),
          ],
        ),
      ),
    );
  }
}
