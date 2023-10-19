import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

@GenerateMocks([DataConnectionChecker, Database, NavigatorObserver],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
