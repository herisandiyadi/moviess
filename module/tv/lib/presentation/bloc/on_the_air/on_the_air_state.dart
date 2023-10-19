part of 'on_the_air_bloc.dart';

abstract class OnTheAirState extends Equatable {
  const OnTheAirState();

  @override
  List<Object> get props => [];
}

final class OnTheAirInitial extends OnTheAirState {}

final class OnTheAirLoading extends OnTheAirState {}

final class OnTheAirFailed extends OnTheAirState {
  final String message;
  const OnTheAirFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class OnTheAirSuccess extends OnTheAirState {
  final List<Tv> ontheAir;
  const OnTheAirSuccess(this.ontheAir);

  @override
  List<Object> get props => [ontheAir];
}
