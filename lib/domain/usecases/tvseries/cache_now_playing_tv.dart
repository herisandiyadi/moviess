import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class CacheNowPlayingTv {
  final TVRepository repository;

  CacheNowPlayingTv(this.repository);

  Future<void> execute(List<Tv> tv) {
    return repository.cacheNowPlayingTv(tv);
  }
}
