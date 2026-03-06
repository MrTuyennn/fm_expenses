import 'dart:convert';
import 'dart:developer' as developer;
import 'package:app_logger/src/logger_service.dart';

final logger = LoggerCustom();

class LogColor {
  static const reset = '\x1B[0m';
  static const red = '\x1B[91m';
  static const green = '\x1B[92m';
  static const yellow = '\x1B[93m';
  static const magenta = '\x1B[95m';
}

class LoggerCustom extends LoggerService {
  static const showMethod = true;

  String prettyJson(dynamic data) {
    if (data is Map || data is List) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    }
    return data.toString();
  }

  void _printLog(
    String level,
    dynamic data, {
    StackTrace? stackTrace,
    dynamic arguments,
  }) {
    final trace = StackTrace.current.toString().split('\n')[2];
    final pattern = RegExp(r'#\d+\s+(.+?)\.(.+?) \((.+?):(\d+):(\d+)\)');
    final match = pattern.firstMatch(trace);

    String file = 'unknown';
    String method = 'unknown';
    String line = '0';

    if (match != null) {
      method = match.group(2) ?? method;
      final fullPath = match.group(3) ?? file;
      file = fullPath.split('/').last.replaceAll('.dart', '');
      line = match.group(4) ?? line;
    }

    final jsonMessage = prettyJson(data);

    final header = '[$level][$file:$line] ${showMethod ? '$method\n' : '\n'}';

    developer.log(
      '${_color(level)}$header$jsonMessage${LogColor.reset}',
      name: 'flutter',
      stackTrace: stackTrace,
    );
  }

  String _color(String level) {
    switch (level) {
      case 'INFO':
        return LogColor.green;
      case 'WARN':
        return LogColor.yellow;
      case 'ERROR':
        return LogColor.red;
      default:
        return LogColor.green;
    }
  }

  @override
  void d(dynamic data, {stackTrace, dynamic arguments}) {
    _printLog('DEBUG', data, stackTrace: stackTrace, arguments: arguments);
  }

  @override
  void i(dynamic data, {stackTrace, dynamic arguments}) {
    _printLog('INFO', data, stackTrace: stackTrace, arguments: arguments);
  }

  @override
  void w(dynamic data, {stackTrace, dynamic arguments}) {
    _printLog('WARN', data, stackTrace: stackTrace, arguments: arguments);
  }

  @override
  void e(dynamic error, {stackTrace, dynamic arguments}) {
    _printLog('ERROR', error, stackTrace: stackTrace, arguments: arguments);
  }
}
