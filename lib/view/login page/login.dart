import 'package:flutter/material.dart';
import 'package:login/api/api.dart';
import 'package:login/model/api_response.dart';
import 'package:login/view/Home page/home.dart';
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

  void submitted() async {
    final FormState? form = _formKey.currentState;
    final BuildContext context = this.context;

    if (!form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fix the errors in red before submitting.')));
    } else {

      form.save();
  
      bool isSuccessful = await authenticateUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      //user1@gmail.com
      //12345678
      // print(response.isSuccessful);
      if (isSuccessful) {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage(title: 'home')),
          ModalRoute.withName('/home'),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Login failed. Please check your credentials and try again.')));
      }
    }
    
  }

  // void _saveAndRedirectToHome() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   Navigator.pushNamedAndRemoveUntil(
  //       context, '/home', ModalRoute.withName('/home'),
  //       arguments: (apiResponse.Data as User));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                      icon: const Icon(Icons.email_rounded),
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
                      icon: const Icon(Icons.password_rounded),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: ElevatedButton.icon(
                        onPressed: submitted,
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
