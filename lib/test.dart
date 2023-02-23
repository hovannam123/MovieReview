import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> getSessionId(
    String apiKey, String username, String password) async {
  final requestTokenResponse = await http.post(
    Uri.parse('https://api.themoviedb.org/3/authentication/token/new'),
    body: {'api_key': apiKey},
  );

  final requestToken = jsonDecode(requestTokenResponse.body)['request_token'];

  final validateRequestTokenResponse = await http.post(
    Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/validate_with_login'),
    body: {
      'api_key': apiKey,
      'username': username,
      'password': password,
      'request_token': requestToken,
    },
  );

  final sessionIdResponse = await http.post(
    Uri.parse('https://api.themoviedb.org/3/authentication/session/new'),
    body: {'api_key': apiKey, 'request_token': requestToken},
  );

  final sessionId = jsonDecode(sessionIdResponse.body)['session_id'];

  return sessionId;
}
