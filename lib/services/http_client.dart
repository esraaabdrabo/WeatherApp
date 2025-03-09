import 'package:http/http.dart';

class HttpClient {
  // Private constructor to ensure singleton instance
  HttpClient._();
  static final HttpClient _instance = HttpClient._();
  static HttpClient get instance => _instance;
  final Client _client = Client();

  /// Sends a GET request to the given URL with optional headers.
  ///
  /// [url] The URL to send the GET request to.
  /// [headers] Optional headers to include in the request.

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _client.get(Uri.parse(url).replace(queryParameters: queryParameters),
        headers: headers);
  }
}
