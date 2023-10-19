import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_production_country.dart';

class TvProductionCountryModel extends Equatable {
  final String? iso31661;
  final String? name;

  const TvProductionCountryModel({
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
      iso31661: iso31661,
      name: name,
    );
  }

  @override
  List<Object?> get props => [iso31661, name];
}
