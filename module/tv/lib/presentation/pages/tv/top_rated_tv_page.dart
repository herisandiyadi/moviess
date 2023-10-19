import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedTvBloc>().add(const FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.toprated[index];
                  return TvCardList(tvShow);
                },
                itemCount: state.toprated.length,
              );
            } else if (state is TopRatedTvFailed) {
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
