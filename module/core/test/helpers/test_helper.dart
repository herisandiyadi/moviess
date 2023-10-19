import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/data/datasources/tv_remote_datasource.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NetworkInfo,
  DataConnectionChecker,
  Database,
  DatabaseHelper,
  MovieLocalDataSource,
  MovieRemoteDataSource,
  TvLocalDataSource,
  TVRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
