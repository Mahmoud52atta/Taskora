import 'dart:async';
import 'package:to_do_app/core/api/api_consumer.dart';
import 'package:to_do_app/core/errors/service_errore.dart';
import 'package:to_do_app/core/errors/error_model.dart';

class MockApiConsumer extends ApiConsumer {
  // Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    await _simulateDelay();

    // Mock responses based on path
    if (path.contains('auth/profile')) {
      return {
        '_id': 'mock_user_id_123',
        'displayName': 'Test User',
        'phone': '+1234567890',
        'address': 'Test Address, City',
        'experienceYears': '3',
        'level': 'Advanced',
        'profilePic': 'https://via.placeholder.com/150',
      };
    } else if (path.contains('auth/refresh-token')) {
      // Mock refresh token response
      return {
        'access_token':
            'mock_new_access_token_${DateTime.now().millisecondsSinceEpoch}',
        'refresh_token':
            'mock_new_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      };
    } else if (path.contains('todos')) {
      return [
        {
          '_id': 'task_1',
          'title': 'Complete Flutter App Development',
          'desc':
              'Finish the to-do app development with all features implemented',
          'priority': 'high',
          'status': 'waiting',
          'dueDate': '2024-01-15',
          'image':
              'https://via.placeholder.com/300x200/5F33E1/FFFFFF?text=Task+1',
        },
        {
          '_id': 'task_2',
          'title': 'Test API Integration',
          'desc':
              'Test the mock API functionality and ensure all endpoints work',
          'priority': 'medium',
          'status': 'in_progress',
          'dueDate': '2024-01-20',
          'image':
              'https://via.placeholder.com/300x200/7C3AED/FFFFFF?text=Task+2',
        },
        {
          '_id': 'task_3',
          'title': 'Deploy to Production',
          'desc':
              'Deploy the app to production servers and monitor performance',
          'priority': 'low',
          'status': 'completed',
          'dueDate': '2024-01-25',
          'image':
              'https://via.placeholder.com/300x200/10B981/FFFFFF?text=Task+3',
        },
        {
          '_id': 'task_4',
          'title': 'User Interface Design',
          'desc': 'Design and implement beautiful user interface components',
          'priority': 'high',
          'status': 'waiting',
          'dueDate': '2024-01-30',
          'image':
              'https://via.placeholder.com/300x200/F59E0B/FFFFFF?text=Task+4',
        },
      ];
    }

    throw ServerException(
      errModel: ErrorModel(errorMessage: 'Mock API: Endpoint not found'),
    );
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    await _simulateDelay();

    if (path.contains('auth/login')) {
      // Mock login response
      final phone = data['phone'] ?? '';
      final password = data['password'] ?? '';

      if (phone.isEmpty || password.isEmpty) {
        throw ServerException(
          errModel: ErrorModel(
              errorMessage: 'Phone number and password are required'),
        );
      }

      if (password.length < 6) {
        throw ServerException(
          errModel: ErrorModel(
              errorMessage: 'Password must be at least 6 characters'),
        );
      }

      // Accept any valid phone number and password
      return {
        '_id': 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
        'phone': phone,
        'password': password,
        'access_token':
            'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        'refresh_token':
            'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      };
    } else if (path.contains('auth/register')) {
      // Mock registration response
      return {
        '_id': 'mock_user_id_${DateTime.now().millisecondsSinceEpoch}',
        'displayName': data['displayName'] ?? 'Test User',
        'phone': data['phone'] ?? '',
        'access_token':
            'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        'refresh_token':
            'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      };
    } else if (path.contains('auth/logout')) {
      // Mock logout response
      return {'message': 'Logged out successfully'};
    } else if (path.contains('todos')) {
      // Mock add task response - return as list to match expected format
      final newTask = {
        '_id': 'task_${DateTime.now().millisecondsSinceEpoch}',
        'title': data['title'] ?? 'New Task',
        'desc': data['desc'] ?? 'Task description',
        'priority': data['priority'] ?? 'medium',
        'status': 'waiting',
        'dueDate': data['dueDate'] ?? '2024-01-30',
        'image': data['image'] ??
            'https://via.placeholder.com/300x200/5F33E1/FFFFFF?text=New+Task',
      };
      return [newTask]; // Return as list
    }

    throw ServerException(
      errModel: ErrorModel(errorMessage: 'Mock API: Endpoint not found'),
    );
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    await _simulateDelay();

    if (path.contains('todos/')) {
      // Mock edit task response - return as list to match expected format
      final updatedTask = {
        '_id': path.split('/').last,
        'title': data['title'] ?? 'Updated Task',
        'desc': data['desc'] ?? 'Updated description',
        'priority': data['priority'] ?? 'medium',
        'status': data['status'] ?? 'waiting',
        'dueDate': data['dueDate'] ?? '2024-01-30',
        'image': data['image'] ??
            'https://via.placeholder.com/300x200/5F33E1/FFFFFF?text=Updated+Task',
      };
      return [updatedTask]; // Return as list
    }

    throw ServerException(
      errModel: ErrorModel(errorMessage: 'Mock API: Endpoint not found'),
    );
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    return put(path,
        data: data, queryParameters: queryParameters, isFromData: isFromData);
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    await _simulateDelay();

    if (path.contains('todos/')) {
      // Mock delete task response
      return {'message': 'Task deleted successfully'};
    } else if (path.contains('auth/logout')) {
      // Mock logout response
      return {'message': 'Logged out successfully'};
    }

    throw ServerException(
      errModel: ErrorModel(errorMessage: 'Mock API: Endpoint not found'),
    );
  }
}
