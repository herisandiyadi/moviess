import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';

class OnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/ontheair';

  const OnTheAirPage({super.key});

  @override
  _OnTheAirPageState createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<OnTheAirBloc>().add(const FetchOnTheAirTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirBloc, OnTheAirState>(
          builder: (context, state) {
            if (state is OnTheAirLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.ontheAir[index];
                  return TvCardList(tvShow);
                },
                itemCount: state.ontheAir.length,
              );
            } else if (state is OnTheAirFailed) {
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
