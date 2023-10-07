import 'dart:convert';

import 'package:ditonton/data/models/tv_network_model.dart';
import 'package:ditonton/domain/entities/tv_network.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final testTvNetwork = TvNetworkModel(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );

  final tvNetworkEntity = TvNetwork(
    id: 1,
    logoPath: 'logoPath',
    name: 'name',
    originCountry: 'originCountry',
  );

  test('Test tv network model to Json', () {
    final jsonResult = testTvNetwork.toJson();
    final testToEntity = testTvNetwork.toEntity();
    expect(jsonResult['id'], 1);
    expect(testToEntity, tvNetworkEntity);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_network.json'));
    // act
    final result = TvNetworkModel.fromJson(jsonMap);
    // assert
    expect(result, testTvNetwork);
  });
}
