part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();
}

class FetchSearchTv extends SearchTvEvent {
  final String query;

  const FetchSearchTv(this.query);

  @override
  List<Object?> get props => [query];
}
