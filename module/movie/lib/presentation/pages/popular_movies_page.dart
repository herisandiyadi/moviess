import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular/popular_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularBloc>().add(
            const FetchPopularMovies(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popular[index];
                  return MovieCard(movie);
                },
                itemCount: state.popular.length,
              );
            } else if (state is PopularFailed) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
