import 'dart:io';

String fixture(String path) => File('test/_fixtures/$path').readAsStringSync();
