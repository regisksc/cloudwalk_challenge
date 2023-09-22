import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  await FlutterDriver.connect();
  await integrationDriver(
    timeout: const Duration(seconds: 10),
    responseDataCallback: (Map<String, dynamic>? data) async {
      await fs.directory(_destinationDirectory).create(recursive: true);

      final file = fs.file(
        path.join(_destinationDirectory, '$_testOutputFilename.json'),
      );

      if (data != null) {
        final resultString = const JsonEncoder.withIndent('  ').convert(data);
        await file.writeAsString(resultString);
      }
    },
  );
}

const _testOutputFilename = 'integration_response_data';
const _destinationDirectory = 'integration_test';
