import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_ontheair.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAir = <Tv>[];
  List<Tv> get onTheAir => _onTheAir;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getTvSeriesOnTheAir,
    required this.getTVSeriesPopuler,
    required this.getTvTopRated,
  });

  final GetTvSeriesOnTheAir getTvSeriesOnTheAir;
  final GetTVSeriesPopuler getTVSeriesPopuler;
  final GetTvTopRated getTvTopRated;

  Future<void> fetchOnTheAir() async {
    _onTheAirState = RequestState.Loading;

    notifyListeners();

    final result = await getTvSeriesOnTheAir.execute();

    result.fold((failure) {
      _onTheAirState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowData) {
      _onTheAirState = RequestState.Loaded;
      _onTheAir = tvShowData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvShow() async {
    _popularTvState = RequestState.Loading;

    notifyListeners();

    final result = await getTVSeriesPopuler.execute();

    result.fold((failure) {
      _popularTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowData) {
      _popularTvState = RequestState.Loaded;
      _popularTv = tvShowData;
      notifyListeners();
    });
  }

  Future<void> fetchTvTopRated() async {
    _topRatedState = RequestState.Loading;

    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold((failure) {
      _topRatedState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvShowData) {
      _topRatedState = RequestState.Loaded;
      _topRatedTv = tvShowData;
      notifyListeners();
    });
  }
}
