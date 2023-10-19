import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';

class NowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/nowplaying-movie';

  const NowPlayingPage({super.key});

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingMoviesBloc>().add(
            const FetchNowPlayingMovies(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
          builder: (context, state) {
            if (state is NowPlayingMoviesLoading) {
              return const Center(
                key: Key('nowplaying-center'),
                child: CircularProgressIndicator(
                  key: Key('nowplaying-circullar'),
                ),
              );
            } else if (state is NowPlayingMoviesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.nowPlaying[index];
                  return MovieCard(movie);
                },
                itemCount: state.nowPlaying.length,
              );
            } else if (state is NowPlayingMoviesFailed) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Data kosong'),
              );
            }
          },
        ),
      ),
    );
  }
}
