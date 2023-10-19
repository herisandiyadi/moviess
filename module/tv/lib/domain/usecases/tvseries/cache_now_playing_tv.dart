import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class CacheNowPlayingTv {
  final TVRepository repository;

  CacheNowPlayingTv(this.repository);

  Future<void> execute(List<Tv> tv) {
    return repository.cacheNowPlayingTv(tv);
  }
}
