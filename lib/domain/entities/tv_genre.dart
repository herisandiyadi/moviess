import 'package:equatable/equatable.dart';

class TVGenre extends Equatable {
  final int? id;
  final String? name;

  TVGenre({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
