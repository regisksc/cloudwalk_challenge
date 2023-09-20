import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../core.dart';

class ConnectionHandleDecorator<Output, Input> extends Usecase<Output, Input> {
  ConnectionHandleDecorator({
    required Usecase<Output, Input> cacheDecoratee,
    required Usecase<Output, Input> remoteDecoratee,
    required Connectivity connectivity,
  })  : _cacheDecoratee = cacheDecoratee,
        _remoteDecoratee = remoteDecoratee,
        _connectivityHelper = connectivity;

  final Usecase<Output, Input> _cacheDecoratee;
  final Usecase<Output, Input> _remoteDecoratee;
  final Connectivity _connectivityHelper;

  @override
  Future<Output> call(Input params) async {
    try {
      return await _remoteDecoratee(params);
    } catch (error) {
      if (error is BadRequestFailure || error is UnauthorizedFailure) throw ClientFailure();
      if (error is TimeoutException || error is SocketException) {
        final connectivityStatus = await _connectivityHelper.checkConnectivity();
        if (connectivityStatus == ConnectivityResult.none) return _cacheDecoratee(params);
      }
      rethrow;
    }
  }
}
