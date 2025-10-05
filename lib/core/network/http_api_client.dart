
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/core/config/config_env.dart';
import 'i_api_client.dart';
import '../error/api_exception.dart';

class HttpApiClient extends IApiClient{

  http.Client _client = http.Client();
  final String _baseUrl;

  HttpApiClient({http.Client? client}) : _client = client ?? http.Client(), _baseUrl = ConfigEnv.baseUrl;

  Uri _buildUri(String path, {Map<String, dynamic>? query}){
    final uri = Uri.parse('$_baseUrl$path');
    if (query == null) return uri;
    final uriBuilder = uri.replace(queryParameters: query);
    return uriBuilder;
  }
  Map<String, String> _headers([Map<String, String>? extra]) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (extra != null) ...extra,
      };
      
  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic data)? fromJson,
  }) async {
    final res = await _client.get(_buildUri(path, query: query), headers: _headers());
    return _handleResponse(res, fromJson);
  }


  @override
  Future<T> post<T>(
    String path, {
    Object? body,
    T Function(dynamic data)? fromJson,
  }) async {
    final res = await _client.post(
      _buildUri(path),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(res, fromJson);
  }

  @override
  Future<T> put<T>(
    String path, {
    Object? body,
    T Function(dynamic data)? fromJson,
  }) async {
    final res = await _client.put(
      _buildUri(path),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(res, fromJson);
  }

  @override
  Future<T> delete<T>(
    String path, {
    T Function(dynamic data)? fromJson,
  }) async {
    final res = await _client.delete(_buildUri(path), headers: _headers());
    return _handleResponse(res, fromJson);
  }

  T _handleResponse<T>(http.Response res, T Function(dynamic data)? fromJson) {
    final decoded = res.body.isNotEmpty ? jsonDecode(res.body) : null;
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return fromJson != null ? fromJson(decoded) : decoded as T;
    }
    throw ApiException(
      decoded?['message'] ?? 'HTTP Error',
      statusCode: res.statusCode,
      data: decoded,
    );
  }
}