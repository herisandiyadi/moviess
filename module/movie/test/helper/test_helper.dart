import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  NetworkInfo,
  DataConnectionChecker,
  NavigatorObserver,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
