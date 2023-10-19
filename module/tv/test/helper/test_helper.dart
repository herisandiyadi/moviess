import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TVRepository,
  NetworkInfo,
  DataConnectionChecker,
  NavigatorObserver,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
