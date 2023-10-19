import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TVRemoteDataSource {
  Future<List<TvModel>> getTVSeriesPopuler();
  Future<List<TvModel>> getTvSeriesTopRated();
  Future<List<TvModel>> getTvSeriesOnTheAir();
  Future<TvDetailModel> getTvDetail(int id);
  Future<List<TvModel>> getTvRecomendations(int id);
  Future<List<TvModel>> searchTvShow(String query);
}

class TVRemoteDatasourceImpl implements TVRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDatasourceImpl({required this.client});

  @override
  Future<List<TvModel>> getTVSeriesPopuler() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvSeriesTopRated() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvSeriesOnTheAir() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvShow(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecomendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
