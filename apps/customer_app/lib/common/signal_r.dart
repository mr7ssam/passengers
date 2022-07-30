import 'dart:async';

import 'package:customer_app/app/user/data/local/data_sources/token_storage.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  SignalRService(this._tokenStorage)
      : connections = {},
        _startCompleters = {};
  final TokenStorageImpl _tokenStorage;
  final Map<String, HubConnection> connections;
  final Map<String, Completer<void>> _startCompleters;

  Future<HubConnection> openHub(
    String hubUrl, {
    String? name,
    bool start = true,
    HttpConnectionOptions? options,
  }) async {
    if (connections[hubUrl] == null) {
      final hubName = name ?? hubUrl.split('/').last;
      final hubConnection = HubConnectionBuilder()
          .withUrl(
            hubUrl,
            options: options ?? _defaultHttpConnectionOptions(hubName),
          )
          .withAutomaticReconnect()
          .build();
      connections[hubUrl] = hubConnection;
    }
    if (start && !isConnected(hubUrl)) {
      await startHub(hubUrl);
    }

    return connections[hubUrl]!;
  }

  bool isConnected(String hub) {
    return connections[hub] != null &&
        connections[hub]!.state == HubConnectionState.Connected;
  }

  Future<void> startHub(String hubUrl) async {
    _assertHubIsBuilt(hubUrl);
    var completer = _startCompleters[hubUrl];
    if (completer == null) {
      completer = Completer();
      completer.complete(connections[hubUrl]!.start());
      _startCompleters[hubUrl] = completer;
    }
    await completer.future;
  }

  Future<void> closeHub(String hubUrl) async {
    final hubConnection = connections[hubUrl];
    if (hubConnection != null) {
      await connections[hubUrl]!.stop();
      connections.remove(hubUrl);
      _startCompleters.remove(hubUrl);
    }
  }

  void on({
    required String hubUrl,
    required String methodName,
    required MethodInvocationFunc method,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.on(methodName, method);
  }

  void off({
    required String hubUrl,
    required String methodName,
    MethodInvocationFunc? method,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.off(methodName, method: method);
  }

  _assertHubIsBuilt(String hubUrl) {
    final hubConnection = connections[hubUrl];
    assert(hubConnection != null, 'Make sure you opened the hub');
  }

  HttpConnectionOptions _defaultHttpConnectionOptions(String hubName) {
    final token = _tokenStorage.read()?.accessToken;
    return HttpConnectionOptions(
      logMessageContent: true,
      requestTimeout: 30000,
      accessTokenFactory: token != null ? () async => token : null,
      // logger: Logger('SignalR($hubName)'),
    );
  }
}

void osama(List<Object>? args) {
  print(args?[0]);
}
