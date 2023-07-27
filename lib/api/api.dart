import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/api/api_error.dart';
import 'package:login/api/api_response.dart';
import '../model/user.dart';

String baseUrl = 'http://192.168.5.67:3002/api/';

Future<ApiResponse> authenticateUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse('${baseUrl}login'), body: {
      "email" : email,
      "password" : password
      
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.Data = User.json(json.decode(response.body));
        break;
      case 401:
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}
