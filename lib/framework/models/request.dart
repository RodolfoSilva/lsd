import 'method.dart';

/// This file contains the definition of the [Request] class.
class Request {
  const Request({
    required this.id,
    required this.url,
    required this.method,
    this.queryParameters = const {},
    this.headers = const {},
    this.data = const {},
  });

  /// The id of the request. This is used when we want to observe the loading
  /// state of the request. If the id is not provided, the request will be
  /// identified by the url.
  final String id;

  /// The url of the request.
  final String url;

  /// The method of the request. (get, post, put, delete)
  final Method method;

  /// The query parameters of the request.
  final Map<String, dynamic>? queryParameters;

  /// The additional headers of the request.
  final Map<String, dynamic>? headers;

  /// The data of the request.
  final Map<String, dynamic>? data;

  /// Creates a new request from a json object.
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] ?? json['url'],
      url: json['url'],
      method: Method.fromString(json['method'] as String? ?? "GET"),
      queryParameters: json['query_parameters'],
      headers: json['headers'],
      data: json['data'],
    );
  }

  /// Creates a new request from a json object.
  Request copyWith({
    String? id,
    String? url,
    Method? method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return Request(
      id: id ?? this.id,
      url: url ?? this.url,
      method: method ?? this.method,
      queryParameters: queryParameters ?? this.queryParameters,
      headers: headers ?? this.headers,
      data: data ?? this.data,
    );
  }
}
