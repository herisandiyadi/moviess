part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();
}

class FetchPopularTv extends PopularEvent {
  const FetchPopularTv();

  @override
  List<Object?> get props => [];
}
