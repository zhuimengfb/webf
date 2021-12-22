import '../module.dart';
import '../isolate_server.dart';
import '../ui_inspector.dart';

class InspectorLogModule extends IsolateInspectorModule {
  InspectorLogModule(IsolateInspectorServer server): super(server);

  @override
  String get name => 'Log';

  @override
  void receiveFromFrontend(int? id, String method, Map<String, dynamic>? params) {
    // callNativeInspectorMethod(id, method, params);
  }
}


class LogEntryEvent extends InspectorEvent {
  // Allowed Values: xml, javascript, network, storage, appcache,
  // rendering, security, deprecation, worker, violation, intervention,
  // recommendation, other
  String source = 'network';

  // Allowed Values: verbose, info, warning, error
  String level;

  // The output text.
  String text;

  String? url;

  LogEntryEvent({
    required this.level,
    required this.text,
    this.url,
  });

  @override
  String get method => 'Log.entryAdded';

  @override
  JSONEncodable? get params => JSONEncodableMap({
    'entry': {
      'source': source,
      'level': level,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      if (url != null) 'url': url,
    },
  });
}
