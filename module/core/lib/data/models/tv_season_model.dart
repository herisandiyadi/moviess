import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_season.dart';

class TVSeasonModel extends Equatable {
  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const TVSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TVSeasonModel.fromJson(Map<String, dynamic> json) => TVSeasonModel(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  TVSeason toEntity() {
    return TVSeason(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage
      ];
}
