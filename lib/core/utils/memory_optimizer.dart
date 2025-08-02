import 'dart:async';
import 'package:flutter/foundation.dart';

class MemoryOptimizer {
  static final MemoryOptimizer _instance = MemoryOptimizer._internal();
  factory MemoryOptimizer() => _instance;
  MemoryOptimizer._internal();

  final Map<String, Timer> _timers = {};
  final List<StreamSubscription> _subscriptions = [];

  // Clear all timers to prevent memory leaks
  void clearTimers() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  // Add a timer with automatic cleanup
  Timer addTimer(String key, Duration duration, VoidCallback callback) {
    // Cancel existing timer if any
    _timers[key]?.cancel();

    final timer = Timer(duration, callback);
    _timers[key] = timer;
    return timer;
  }

  // Add a periodic timer with automatic cleanup
  Timer addPeriodicTimer(String key, Duration duration, VoidCallback callback) {
    // Cancel existing timer if any
    _timers[key]?.cancel();

    final timer = Timer.periodic(duration, (_) => callback());
    _timers[key] = timer;
    return timer;
  }

  // Add a stream subscription with automatic cleanup
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  // Clear all stream subscriptions
  void clearSubscriptions() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  // Dispose all resources
  void dispose() {
    clearTimers();
    clearSubscriptions();
  }

  // Get memory usage statistics (debug only)
  void printMemoryStats() {
    if (!kDebugMode) return;

    print('\n🧠 Memory Statistics:');
    print('Active Timers: ${_timers.length}');
    print('Active Subscriptions: ${_subscriptions.length}');

    // Force garbage collection in debug mode
    // Note: This is only available in debug mode
    if (kDebugMode) {
      // You can add more detailed memory analysis here
      print('Memory optimization active');
    }
  }
}

// Mixin for automatic memory management
mixin MemoryOptimizedMixin {
  final MemoryOptimizer _memoryOptimizer = MemoryOptimizer();

  @protected
  Timer addTimer(String key, Duration duration, VoidCallback callback) {
    return _memoryOptimizer.addTimer(key, duration, callback);
  }

  @protected
  Timer addPeriodicTimer(String key, Duration duration, VoidCallback callback) {
    return _memoryOptimizer.addPeriodicTimer(key, duration, callback);
  }

  @protected
  void addSubscription(StreamSubscription subscription) {
    _memoryOptimizer.addSubscription(subscription);
  }

  @protected
  void disposeMemory() {
    _memoryOptimizer.dispose();
  }
}
