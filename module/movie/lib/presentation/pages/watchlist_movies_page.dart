import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieBloc>(context, listen: false)
            .add(const FetchWatchlistMovie()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(const FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
            builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieSuccess) {
            return ListView.builder(
                itemCount: state.watchListMovie.length,
                itemBuilder: (context, index) {
                  final movie = state.watchListMovie[index];
                  return MovieCard(movie);
                });
          } else if (state is WatchlistMovieFailed) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Data Kosong'),
            );
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
