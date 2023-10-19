import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetCacheNowPlayingTv {
  final TVRepository repository;

  GetCacheNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getCachedNowPlayingTv();
  }
}
