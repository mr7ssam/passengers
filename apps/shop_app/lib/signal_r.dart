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
    required MethodInvacationFunc method,
  }) {
    _assertHubIsBuilt(hubUrl);
    connections[hubUrl]!.on(methodName, method);
  }

  void off({
    required String hubUrl,
    required String methodName,
    MethodInvacationFunc? method,
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
      accessTokenFactory: () async =>
          'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjY0NmJmMGQ3LWNjNjgtNGQ2YS1lNWNlLTA4ZGE0Y2ZkMDljYSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJDdXN0b21lcjA5NTYwNTc4ODYiLCJUeXBlIjoiQ3VzdG9tZXIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDdXN0b21lciIsImV4cCI6MTY1NTExMTk3MSwiaXNzIjoiaHR0cHM6Ly9uYXdhdC1zb2x1dGlvbnMuY29tLyIsImF1ZCI6Imh0dHBzOi8vbmF3YXQtc29sdXRpb25zLmNvbS8ifQ.xRROu8fA27ghHOSVbg0tF3eGEGcOf6osf3j4m1mxnQc',
      logger: Logger('SignalR($hubName)'),
    );
  }
}

void main() async {
  final s = SignalRService();
  final hub = await s.openHub('https://nawat-solutions.com/orderHub');
  print('connected');
  hub.on("Test", osama);
  // final r = await hub.invoke('main', args: ['String']);
  // print(r);

  await Future.delayed(Duration(seconds: 90));
}

void osama(List<dynamic>? args) {
  print(args?[0]);
}
