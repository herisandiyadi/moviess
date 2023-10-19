import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvShowDetailPage({super.key, required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(FetchDetailTV(widget.id));
      context.read<DetailTvBloc>().add(StatusWatchlistTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailTvBloc, DetailTvState>(
        listener: (context, state) {
          final message = state.watchlistMessage;

          if (message == DetailTvBloc.addWatchlistMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (message == DetailTvBloc.removeWatchlistMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        listenWhen: (previous, current) {
          return previous.watchlistMessage != current.watchlistMessage &&
              current.watchlistMessage != '';
        },
        builder: (context, state) {
          final detailState = state.detailState;

          if (detailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (detailState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContentTv(
                state.tvDetail!,
                state.tvRecommendations!,
                state.isAddedtoWatchlist,
              ),
            );
          } else if (detailState == RequestState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContentTv extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;

  const DetailContentTv(
      this.tvDetail, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name!,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<DetailTvBloc>()
                                      .add(AddedWatchlistTv(tvDetail));
                                } else {
                                  context
                                      .read<DetailTvBloc>()
                                      .add(RemoveFromWatchlistTv(tvDetail));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenresTv(tvDetail.genres!),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview!,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<DetailTvBloc, DetailTvState>(
                              builder: (context, state) {
                                final recommendationState =
                                    state.recommendationState;
                                if (recommendationState ==
                                    RequestState.Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (recommendationState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else if (recommendationState ==
                                    RequestState.Error) {
                                  return Text(state.message);
                                } else {
                                  return const Text('No Recommendations');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenresTv(List<TVGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name!}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
