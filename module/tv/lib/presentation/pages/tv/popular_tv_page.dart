import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvPage({super.key});

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvBloc>().add(const FetchPopularTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.popular[index];
                  return TvCardList(tvShow);
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
