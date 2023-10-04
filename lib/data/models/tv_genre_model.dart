import 'package:ditonton/domain/entities/tv_genre.dart';
import 'package:equatable/equatable.dart';

class TVGenreModel extends Equatable {
  final int? id;
  final String? name;

  TVGenreModel({
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
    return TVGenre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
