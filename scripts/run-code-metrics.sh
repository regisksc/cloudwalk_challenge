#!/bin/bash

cd ..
echo '############################### Running code metrics #######################################'
flutter pub global activate dart_code_metrics 
ls
flutter pub global run dart_code_metrics:metrics check-unnecessary-nullable --disable-sunset-warning --no-fatal-found ./app
flutter pub global run dart_code_metrics:metrics check-unused-code --no-fatal-unused --disable-sunset-warning --exclude "{**.g.dart,**.gen.dart,**.freezed.dart}" ./app
flutter pub global run dart_code_metrics:metrics check-unused-files --disable-sunset-warning --no-fatal-unused --exclude "{**.g.dart,**.gen.dart,**.freezed.dart,**/*test.dart,**/*main.dart,**/*_plugin_registrant.dart}" ./app
flutter pub global run dart_code_metrics:metrics --reporter=html --disable-sunset-warning --fatal-performance ./app
cd -
echo '############################### Code metrics generated under metrics directory #############'