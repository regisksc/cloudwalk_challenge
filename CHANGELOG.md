# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cities` - `v0.0.2`](#cities---v002)
 - [`core` - `v0.0.2`](#core---v002)
 - [`weather` - `v0.0.2`](#weather---v002)

---

#### `cities` - `v0.0.2`

 - **REFACTOR**(cities,weather): removes error handling from usecase implementation.
 - **REFACTOR**(cities,weather): makes notfoundfailure be rethrown.
 - **REFACTOR**(cities): removes unnecessary async.
 - **FIX**(cities): improves error handling in geolocation.
 - **FIX**(cities): fixes lint issues.
 - **FEAT**(core): adds caching funcionality.
 - **FEAT**(cities): implements remotely geolocate city success path.

#### `core` - `v0.0.2`

 - **REFACTOR**(core): adds a default http method to requests.
 - **REFACTOR**(core): removes InvalidHttpMethod and adds ClientFailure.
 - **FIX**(core): fixes timelapse mixin logic.
 - **FEAT**(core): adds caching funcionality.
 - **FEAT**(weather): adds localization possibility to query.
 - **FEAT**(core): creates error_handle_decorator.
 - **FEAT**(core): add last modified mixin.
 - **FEAT**(core): adds an api helper.
 - **FEAT**(core): adds http requesting.
 - **FEAT**(core): adds protocols.

#### `weather` - `v0.0.2`

 - **REFACTOR**(cities,weather): removes error handling from usecase implementation.
 - **REFACTOR**(cities,weather): makes notfoundfailure be rethrown.
 - **FEAT**(core): adds caching funcionality.
 - **FEAT**(weather): adds localization possibility to query.
 - **FEAT**(weather): implement fetch weather forecast usecase.
 - **FEAT**(core): adds protocols.

