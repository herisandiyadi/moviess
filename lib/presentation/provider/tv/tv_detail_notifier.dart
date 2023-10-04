import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecomendations getTvRecomendations;
  final GetWatchListTVStatus getWatchListTVStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecomendations,
    required this.getWatchListTVStatus,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecomendations = [];
  List<Tv> get tvRecomendations => _tvRecomendations;

  RequestState _recomendationState = RequestState.Empty;
  RequestState get recomendationState => _recomendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchList = false;
  bool get isAddedtoWatchList => _isAddedtoWatchList;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recomendationResult = await getTvRecomendations.execute(id);

    detailResult.fold((failure) {
      _tvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (detailTv) {
      _recomendationState = RequestState.Loading;
      _tvDetail = detailTv;
      notifyListeners();
      recomendationResult.fold((failure) {
        _recomendationState = RequestState.Error;
        _message = failure.message;
      }, (recomendation) {
        _recomendationState = RequestState.Loaded;
        _tvRecomendations = recomendation;
      });
      _tvState = RequestState.Loaded;
      notifyListeners();
    });
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (successMessage) async {
      _watchlistMessage = successMessage;
    });
    await loadWatchlistStatus(tv.id!);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);
    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatus(tv.id!);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListTVStatus.execute(id);
    _isAddedtoWatchList = result;
    notifyListeners();
  }
}
