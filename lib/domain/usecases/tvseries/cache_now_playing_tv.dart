import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class CacheNowPlayingTv {
  final TVRepository repository;

  CacheNowPlayingTv(this.repository);

  Future<void> execute(List<TvTable> tv) {
    return repository.cacheNowPlayingTv(tv);
  }
}
