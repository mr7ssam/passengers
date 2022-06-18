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
    return HttpConnectionOptions(
      logMessageContent: true,
      requestTimeout: 90000,
      transport: HttpTransportType.WebSockets,
      accessTokenFactory: () async =>
          'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjgxZWRkYzUxLWQ5NWUtNDFlMi1kNDg3LTA4ZGE0ZjkzZTJjNSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJDdXN0b21lcjA5NTYwNTc4ODYiLCJUeXBlIjoiQ3VzdG9tZXIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDdXN0b21lciIsImV4cCI6MTY1NTU2MjAzMywiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMjcvIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMjcvIn0.guaQ5I2H_sX3OUB_uO9oTlWSS0ediHH85Wf9LI7UDbY',
      logger: Logger('SignalR($hubName)'),
    );
  }
}

void main() async {
  final s = SignalRService();
  final hub =
      await s.openHub('http://passengers-001-site1.gtempurl.com/orderHub');
  hub.onclose(({error}) {
    print(error);
  });
  print(hub.connectionId);
  print('connected');
  hub.on("Test", osama);
  hub.invoke("BroadcastMessage", args: ['7ssam']);
  hub.invoke("BroadcastMessage", args: ['ttt']);

  await Future.delayed(Duration(seconds: 90));
}

void osama(List<Object>? args) {
  print(args?[0]);
}
