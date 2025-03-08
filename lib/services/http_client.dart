import 'package:http/http.dart';

class HttpClient {
  // Private constructor to ensure singleton instance
  HttpClient._();
  static final HttpClient _instance = HttpClient._();
  static HttpClient get instance => _instance;

  /// Sends a GET request to the given URL with optional headers.
  ///
  /// [url] The URL to send the GET request to.
  /// [headers] Optional headers to include in the request.

  Future<Response> get(Uri url, {Map<String, dynamic>? headers}) async {
    return get(url, headers: headers);
  }
}
