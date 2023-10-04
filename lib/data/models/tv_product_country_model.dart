import 'package:ditonton/domain/entities/tv_production_country.dart';
import 'package:equatable/equatable.dart';

class TvProductionCountryModel extends Equatable {
  final String? iso31661;
  final String? name;

  TvProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  factory TvProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      TvProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };

  TvProductionCountry toEntity() {
    return TvProductionCountry(
      iso31661: this.iso31661,
      name: this.name,
    );
  }

  @override
  List<Object?> get props => [iso31661, name];
}
