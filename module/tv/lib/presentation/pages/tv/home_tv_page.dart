import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/on_the_air_page.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv/presentation/pages/tv/search_tv_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  const HomeTVPage({super.key});
  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<OnTheAirBloc>(context, listen: false).add(
        const FetchOnTheAirTv(),
      );
      Provider.of<PopularTvBloc>(context, listen: false).add(
        const FetchPopularTv(),
      );
      Provider.of<TopRatedTvBloc>(context, listen: false).add(
        const FetchTopRatedTv(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirPage.ROUTE_NAME),
              ),
              BlocBuilder<OnTheAirBloc, OnTheAirState>(
                builder: (context, state) {
                  if (state is OnTheAirLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OnTheAirSuccess) {
                    return TvList(state.ontheAir);
                  } else if (state is OnTheAirFailed) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularState>(
                builder: (context, state) {
                  if (state is PopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSuccess) {
                    return TvList(state.popular);
                  } else if (state is PopularFailed) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
                  if (state is TopRatedTvLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvSuccess) {
                    return TvList(state.toprated);
                  } else if (state is TopRatedTvFailed) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvShow;

  TvList(this.tvShow, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvShow[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShow.length,
      ),
    );
  }
}
