import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;

  TopRatedTvNotifier(this.getTvTopRated);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tvTopRated => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (topRated) {
      _tv = topRated;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
