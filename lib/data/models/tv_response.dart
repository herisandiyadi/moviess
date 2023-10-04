import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TVResponse extends Equatable {
  final List<TvModel> tvSeriesList;
  TVResponse({required this.tvSeriesList});

  factory TVResponse.fromJson(Map<String, dynamic> json) => TVResponse(
        tvSeriesList: List<TvModel>.from(
          (json['results'] as List)
              .map((e) => TvModel.fromJson(e))
              .where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() =>
      {'results': List<dynamic>.from(tvSeriesList.map((e) => e.toJson()))};

  @override
  List<Object?> get props => [tvSeriesList];
}
