import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class NetworkService {
  final String _baseUrl;

  NetworkService(this._baseUrl);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(),
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(),
    );
    return _processResponse(response);
  }

  Map<String, String> _getHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
      case 403:
        throw Exception('Unauthorized access: ${response.body}');
      case 500:
      default:
        throw Exception('Error occurred with status code: ${response.statusCode}');
    }
  }
}
