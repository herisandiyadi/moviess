import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/popular/popular_bloc.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/now_playing_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/widgets/custom_drawer_movie.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';
import 'package:tv/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/on_the_air_page.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv/presentation/pages/tv/search_tv_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<OnTheAirBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DetailTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Moviess',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: CustomDrawer(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => CustomDrawer());
            case NowPlayingPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case OnTheAirPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
