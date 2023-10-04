import 'package:equatable/equatable.dart';

class TvSpokenLanguage extends Equatable {
  final String? englishName;
  final String? iso6391;
  final String? name;

  TvSpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  @override
  List<Object?> get props => [englishName, iso6391, name];
}
