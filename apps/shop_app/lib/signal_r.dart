import 'dart:async';

import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  SignalRService()
      : connections = {},
        _startCompleters = {};

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
    return HttpConnectionOptions(
      logMessageContent: true,
      requestTimeout: 700000,
      accessTokenFactory: () async =>
          'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImUzMjU1ZDEzLTkyNzQtNGJmNS1iOTRhLTM4MzdiMjIzNTNiNyIsImdlbmVyYXRlLWRhdGUiOiI3LzE2LzIwMjIgNzoxMzo1MyBBTSIsImdlbmVyYXRpb24tc3RhbXAiOiIyNmE2ZGFlZC1jYmJhLTRhYmUtYTI5ZC1lYjQyYmY0NzBkNjEiLCJQZXJzb25hbEltYWdlIjoiRG9jdW1lbnRzXFxEcml2ZXIgUGVyc29uYWwgSW1hZ2VzXFw0ZTNlNTg0NC0yMDYwLTQ3ODgtOGZhMi02ZDcxMWY1NDc3OWRAc0N1c3RvbWVyNC5qcGciLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDdXN0b21lciIsImV4cCI6MTcyMTEzOTIzMywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo0NDM3NS8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjQ0Mzc1LyJ9.yaj3wiIKe2qyUqqKeGNdQl9QHu2yD9MPbnZzQy_K8Rk',
      logger: Logger('SignalR($hubName)'),
    );
  }
}

void main() async {
  final s = SignalRService();
  final hub = await s
      .openHub('http://drivetaplatform-001-site1.etempurl.com/deliveryHub/');
  print(hub.state);

  hub.onclose(({error}) {
    print('onٍReconnecting $error');
  });
  hub.onreconnecting(({error}) {
    print('onٍReconnecting $error');
  });
  hub.onreconnected(({connectionId}) {
    print('onreconnected $connectionId');
  });
  hub.on("ReceiveLocations", on);

  await Future.delayed(const Duration(minutes: 15));
}

void on(List<dynamic>? args) {
  print(args);
}
