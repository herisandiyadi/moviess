import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:flutter/cupertino.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetTVSeriesPopuler getTVSeriesPopuler;

  PopularTVNotifier(this.getTVSeriesPopuler);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tvShow => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVSeriesPopuler.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _tv = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
