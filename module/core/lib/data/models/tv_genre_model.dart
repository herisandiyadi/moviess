import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_genre.dart';

class TVGenreModel extends Equatable {
  final int? id;
  final String? name;

  const TVGenreModel({
    this.id,
    this.name,
  });

  factory TVGenreModel.fromJson(Map<String, dynamic> json) => TVGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TVGenre toEntity() {
    return TVGenre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
