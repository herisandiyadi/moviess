import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class CerticatesVerify {
  static Future<HttpClient> insertCert() async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];

      bytes = (await rootBundle.load('assets/certificates/certificate.pem'))
          .buffer
          .asInt8List();

      context.setTrustedCertificatesBytes(bytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        print('cert already trusted!');
      } else {
        print('cert exception : $e');
        rethrow;
      }
    } catch (e) {
      rethrow;
    }

    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = true}) async {
    IOClient client = IOClient(await CerticatesVerify.insertCert());
    return client;
  }
}
