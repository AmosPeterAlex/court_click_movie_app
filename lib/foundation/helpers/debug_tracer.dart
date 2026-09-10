import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class DebugTracer {
  static void log(String message, {String tag = 'APP'}) {
    if (kDebugMode) {
      dev.log('[$tag] $message', name: tag);
    }
  }

  static void info(String message) => log(message, tag: 'INFO');
  static void warn(String message) => log(message, tag: 'WARN');
  static void error(String message, [Object? error, StackTrace? stack]) {
    if (kDebugMode) {
      dev.log('[\x1B[31mERROR\x1B[0m] $message', name: 'ERROR', error: error, stackTrace: stack);
    }
  }

  static void network(String message) => log('🌐 $message', tag: 'NETWORK');
}

class StreamBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    DebugTracer.log('Created: ${bloc.runtimeType}', tag: 'BLOC');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    DebugTracer.log('Event in ${bloc.runtimeType}: $event', tag: 'BLOC');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    DebugTracer.log('State in ${bloc.runtimeType}: ${change.nextState}', tag: 'BLOC');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    DebugTracer.error('Error in ${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    DebugTracer.log('Closed: ${bloc.runtimeType}', tag: 'BLOC');
  }
}
