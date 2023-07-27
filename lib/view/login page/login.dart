import 'package:flutter/material.dart';
import 'package:login/api/api.dart';
import 'package:login/api/api_error.dart';
import 'package:login/api/api_response.dart';
import 'package:login/view/Home%20page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'text_field_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  ApiResponse apiResponse = ApiResponse();
  //TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void Submitted() async {
    
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fix the errors in red before submitting.')));
    } else {
      form.save();
      apiResponse = await authenticateUser(emailController.text, passwordController.text);
      if ((apiResponse.ApiError as ApiError) == null) {
        _saveAndRedirectToHome();
      } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((apiResponse.ApiError as ApiError).error)));
      }
    }
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 241, 212),
        title: Image.asset(
          'assets/iraq.png',
          width: 100,
          height: 100,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 180, 0, 0),
        child: Container(
          height: 500,
          alignment: Alignment.center,
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldLogIn(
                      text: 'Email',
                      icon: Icon(Icons.email_rounded),
                      obscureText: false,
                      controller: emailController,
                    ),
                    /*TextFieldLogIn(
                      text: 'User Nmae',
                      icon: Icon(Icons.account_circle),
                      obscureText: false,
                      controller: usernameController,
                    ),*/
                    TextFieldLogIn(
                      text: 'Password',
                      icon: Icon(Icons.password_rounded),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: ElevatedButton.icon(
                        onPressed: Submitted,
                        icon: const Icon(Icons.login_sharp),
                        label: const Text('LogIn'),
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.green),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color.fromARGB(255, 48, 102, 49);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onHover: (value) {},
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
