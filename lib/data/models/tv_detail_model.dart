import 'package:ditonton/data/models/t_episodetoair_model.dart';
import 'package:ditonton/data/models/tv_genre_model.dart';
import 'package:ditonton/data/models/tv_product_country_model.dart';
import 'package:ditonton/data/models/tv_season_model.dart';
import 'package:ditonton/data/models/tv_spoken_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int>? episodeRunTime;
  final DateTime? firstAirDate;
  final List<TVGenreModel>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final DateTime? lastAirDate;
  final TEpisodeToAirModel? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  // final List<dynamic>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<dynamic>? productionCompanies;
  final List<TvProductionCountryModel>? productionCountries;
  final List<TVSeasonModel>? seasons;
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TvDetailModel({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    //  this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? []
            : List<dynamic>.from(json["created_by"]!.map((x) => x)),
        episodeRunTime: json["episode_run_time"] == null
            ? []
            : List<int>.from(json["episode_run_time"]!.map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        genres: json["genres"] == null
            ? []
            : List<TVGenreModel>.from(
                json["genres"]!.map((x) => TVGenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x)),
        lastAirDate: json["last_air_date"] == null
            ? null
            : DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] == null
            ? null
            : TEpisodeToAirModel.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        // networks: json["networks"] == null
        //     ? []
        //     : List<Map<String, dynamic>>.from(
        //         json["networks"]!.map((x) => TvNetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? []
            : List<dynamic>.from(json["production_companies"]!.map((x) => x)),
        productionCountries: json["production_countries"] == null
            ? []
            : List<TvProductionCountryModel>.from(json["production_countries"]!
                .map((x) => TvProductionCountryModel.fromJson(x))),
        seasons: json["seasons"] == null
            ? []
            : List<TVSeasonModel>.from(
                json["seasons"]!.map((x) => TVSeasonModel.fromJson(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? []
            : List<SpokenLanguageModel>.from(json["spoken_languages"]!
                .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": createdBy == null
            ? []
            : List<dynamic>.from(createdBy!.map((x) => x)),
        "episode_run_time": episodeRunTime == null
            ? []
            : List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "last_air_date":
            "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir?.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        // "networks": networks == null
        //     ? []
        //     : List<dynamic>.from(networks!.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null
            ? []
            : List<dynamic>.from(productionCompanies!.map((x) => x)),
        "production_countries": productionCountries == null
            ? []
            : List<dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "seasons": seasons == null
            ? []
            : List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "spoken_languages": spokenLanguages == null
            ? []
            : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      createdBy: this.createdBy,
      episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres!.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      lastAirDate: this.lastAirDate,
      lastEpisodeToAir: this.lastEpisodeToAir!.toEntity(),
      name: this.name,
      nextEpisodeToAir: this.nextEpisodeToAir,
      // networks: this.networks!.map((network) => network.toEntity()).toList(),
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      productionCountries:
          this.productionCountries!.map((e) => e.toEntity()).toList(),
      seasons: this.seasons!.map((e) => e.toEntity()).toList(),
      spokenLanguages: this.spokenLanguages!.map((e) => e.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        // networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
