import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetCacheNowPlayingTv {
  final TVRepository repository;

  GetCacheNowPlayingTv(this.repository);

  Future<List<TvTable>> execute() {
    return repository.getCachedNowPlayingTv();
  }
}
