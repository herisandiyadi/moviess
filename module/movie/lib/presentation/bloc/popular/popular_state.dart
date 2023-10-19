part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularFailed extends PopularState {
  final String message;
  const PopularFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class PopularSuccess extends PopularState {
  final List<Movie> popular;
  const PopularSuccess(this.popular);

  @override
  List<Object> get props => [popular];
}
