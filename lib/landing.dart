import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'model/api_error.dart';
import 'model/api_response.dart';
import 'model/user.dart';


class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = (prefs.getString('userId') ?? "");
    if (_userId == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      ApiResponse apiResponse = await getUserDetails(_userId);
      if ((apiResponse.ApiError as ApiError) == null) {        
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'),
            arguments: (apiResponse.Data as User));
      } else {        
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}