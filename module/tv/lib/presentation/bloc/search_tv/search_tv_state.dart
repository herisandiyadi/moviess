part of 'search_tv_bloc.dart';

sealed class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

final class SearchTvInitial extends SearchTvState {}

final class SearchTvLoading extends SearchTvState {}

final class SearchTvFailed extends SearchTvState {
  final String message;
  const SearchTvFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchTvSuccess extends SearchTvState {
  final List<Tv> searchTv;
  const SearchTvSuccess(this.searchTv);

  @override
  List<Object> get props => [searchTv];
}
