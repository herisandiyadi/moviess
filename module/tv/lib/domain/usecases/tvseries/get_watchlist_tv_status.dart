import 'package:tv/domain/repositories/tv_repository.dart';

class GetWatchListTVStatus {
  final TVRepository repository;

  GetWatchListTVStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedtoWatchList(id);
  }
}
