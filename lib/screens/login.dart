import 'dart:convert';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/user_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscuredText = true;
  bool _rememberPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await get(
        Uri.parse(
            // 'http://10.0.2.2:8000/api/users?email=$email&password=$password'),
            'http://10.206.50.98:8000/api/users?email=$email&password=$password'),
        // body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        String userTypeString = data['userType'];
        UserType userType;
        if (userTypeString == 'Public User') {
          userType = UserType.publicUser;
        } else if (userTypeString == 'Supplier') {
          userType = UserType.supplier;
        } else {
          console.log("email")
        }
        int userId = data['userID'];
        context.read(userProvider).setUserType(userType);
        context.read(userProvider).setUserId(userId.toString());
        Navigator.of(context).pushNamed('/');
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // vemdora icon
              Image.asset('assets/images/vemdora_icon.png'),

              // welcome text
              Text(
                'Welcome Back !',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // username text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'Email Address',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // password input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscuredText,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscuredText = !_obscuredText;
                        });
                      },
                      icon: Icon(
                        _obscuredText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: '***********',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // text row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Switch(
                        value: _rememberPassword,
                        onChanged: (bool newBool) {
                          setState(() {
                            _rememberPassword = newBool;
                          });
                        }),
                    Text(
                      'Remember me',
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password',
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // Login button
              BlueGradientButton(
                buttonText: 'Login',
                onPress: () {
                  login(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                  );
                },
              ),

              const SizedBox(
                height: 15,
              ),

              // Text row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
