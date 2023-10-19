import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_network.dart';

class TvNetworkModel extends Equatable {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  const TvNetworkModel({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory TvNetworkModel.fromJson(Map<String, dynamic> json) => TvNetworkModel(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };

  TvNetwork toEntity() {
    return TvNetwork(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }

  @override
  List<Object?> get props => [
        id,
        logoPath,
        name,
        originCountry,
      ];
}
