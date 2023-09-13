#!/bin/bash

echo '############################### Set up #######################################'
sudo apt-get update
sudo apt-get install lcov -y
flutter pub global activate remove_from_coverage
echo '############################### Running tests ################################'
flutter test --coverage
flutter test --machine > test-results.json
chmod -R 777 coverage
echo '############################### Generating coverage ##########################'
genhtml coverage/lcov.info -o coverage/html
