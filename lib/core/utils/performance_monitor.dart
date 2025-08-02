import 'dart:async';
import 'package:flutter/foundation.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<Duration>> _measurements = {};

  // Start timing an operation
  void startTimer(String operationName) {
    if (kDebugMode) {
      _timers[operationName] = Stopwatch()..start();
    }
  }

  // Stop timing and record the measurement
  void stopTimer(String operationName) {
    if (kDebugMode && _timers.containsKey(operationName)) {
      final stopwatch = _timers[operationName]!;
      stopwatch.stop();

      _measurements.putIfAbsent(operationName, () => []);
      _measurements[operationName]!.add(stopwatch.elapsed);

      print('⏱️ $operationName: ${stopwatch.elapsed.inMilliseconds}ms');
      _timers.remove(operationName);
    }
  }

  // Get average time for an operation
  Duration? getAverageTime(String operationName) {
    final measurements = _measurements[operationName];
    if (measurements == null || measurements.isEmpty) return null;

    final totalMicroseconds = measurements
        .map((duration) => duration.inMicroseconds)
        .reduce((a, b) => a + b);

    return Duration(microseconds: totalMicroseconds ~/ measurements.length);
  }

  // Get all performance statistics
  Map<String, Duration> getAllAverages() {
    final averages = <String, Duration>{};
    for (final operation in _measurements.keys) {
      final average = getAverageTime(operation);
      if (average != null) {
        averages[operation] = average;
      }
    }
    return averages;
  }

  // Clear all measurements
  void clearMeasurements() {
    _measurements.clear();
    _timers.clear();
  }

  // Print performance report
  void printPerformanceReport() {
    if (!kDebugMode) return;

    print('\n📊 Performance Report:');
    print('=' * 50);

    final averages = getAllAverages();
    if (averages.isEmpty) {
      print('No performance data available');
      return;
    }

    averages.forEach((operation, average) {
      print('$operation: ${average.inMilliseconds}ms (avg)');
    });

    print('=' * 50);
  }
}

// Extension for easier usage
extension PerformanceExtension on Object {
  void measureOperation(String operationName, VoidCallback operation) {
    PerformanceMonitor().startTimer(operationName);
    operation();
    PerformanceMonitor().stopTimer(operationName);
  }

  Future<T> measureAsyncOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    PerformanceMonitor().startTimer(operationName);
    try {
      final result = await operation();
      PerformanceMonitor().stopTimer(operationName);
      return result;
    } catch (e) {
      PerformanceMonitor().stopTimer(operationName);
      rethrow;
    }
  }
}
