# [Mobile Engineer test #1](https://github.com/regisksc/cloudwalk_challenge)

> Truth can only be found in one place: the code. <br/>
> -- Robert C. Martin

## Introduction

This test is intended for candidates applying to Mobile Engineering positions at CloudWalk.

## Task

Build an app for one platform (Android or iOS) to track weather in a fashion manner for a rock'n'roll band staff.

The band staff needs to track the current weather and the forecast for the 5 next days of the main cities where shows of the tour are taking place:

- Silverstone, UK
- São Paulo, Brazil
- Melbourne, Australia
- Monte Carlo, Monaco

## Requirements

The app must contemplate the following requirements:

- Have two screens
- Current weather
- Forecast for the next 5 days
- The concerts list must display the city name and provide a search field in the top (find by city name)
- Must work offline (will be tested with airplane mode)
- Must support multiple resolutions and sizes

## Project Overview

#### This app consists of two screens. The first screen allows users to search for cities, while the second screen is a navigation stack that provides detailed weather information for the selected city.

The app is developed using Flutter and Melos, with a multi-package architecture that includes:

- ./app: The main application package.
- ./packages/core: Contains shared functionality.
- ./packages/cities: Responsible for fetching geolocation data about a city.
- ./packages/weather: Responsible for fetching weather information about a city.

### Highlights:

- Each package follows a clean architecture pattern with domain, data, and presentation layers.
- The app utilizes HTTP requests and Flutter Secure Storage for data handling.
- The app supports both remote and local data fetching, with local data persistency.
- The app prioritizes offline functionality.
- Continuous Integration (CI) and build workflows generate test coverage and cyclomatic complexity reports in HTML format.
- This project features a full test pyramid with golden snapshot tests and maintains a minimum coverage of **80%**<br>
- - [cities package test coverage](https://htmlpreview.github.io/?https://github.com/regisksc/cloudwalk_challenge/blob/main/packages/cities/coverage/html/index.html)<br>

- - [core package test coverage](https://htmlpreview.github.io/?https://github.com/regisksc/cloudwalk_challenge/blob/main/packages/core/coverage/html/index.html)<br>

- - [weather package test coverage](https://htmlpreview.github.io/?https://github.com/regisksc/cloudwalk_challenge/blob/main/packages/weather/coverage/html/index.html)<br>

## Running

### Environment setup:

- A flutter installation with Android emulator or iOS Simulator support
- This repo features a Dockerfile which can be run with:

```
docker build -t flutter-app .
docker run -it -p 8080:8080 flutter-app
```

### Running integration tests:

```
flutter drive \
 --driver=app/integration_test_driver/test_driver.dart \
 --target=app/integration_test/app_test.dart
```

### Running the app:

```
flutter run app/lib/main/main.dart --release
```

### Apks:

The GitHub Actions tab includes build workflow runs that allow you to download APKs for each version of the app.
