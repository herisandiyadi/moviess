part of 'on_the_air_bloc.dart';

abstract class OnTheAirEvent extends Equatable {
  const OnTheAirEvent();
}

class FetchOnTheAirTv extends OnTheAirEvent {
  const FetchOnTheAirTv();

  @override
  List<Object?> get props => [];
}
