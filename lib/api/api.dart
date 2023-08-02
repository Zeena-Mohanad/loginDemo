import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/model/api_error.dart';
import 'package:login/model/api_response.dart';
import '../model/user.dart';

String baseUrl = 'http://192.168.5.67:4000/api/';

Future<bool> authenticateUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  bool isSuccessful = false;
  try {
    final response = await http.post(Uri.parse('${baseUrl}login'),
        body: {"email": email, "password": password});
  
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        {
          print(json.decode(response.body)['dataobj']);
          apiResponse.Data = User.json(json.decode(response.body)['dataobj']);
          isSuccessful = true;
        }

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
  return isSuccessful;
}

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse('${baseUrl}user/$userId'));

    switch (response.statusCode) {
      case 200:
        apiResponse.Data = User.json(json.decode(response.body));
        print('status code 200');
        break;
      case 401:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print((apiResponse.ApiError as ApiError).error);
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}
