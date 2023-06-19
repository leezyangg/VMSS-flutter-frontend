import 'dart:convert';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:vemdora_flutter_frontend/screens/login.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import '../utils/config.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscuredText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void signup(String email, username, password) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      var body = {'email': email, 'userName': username, 'password': password};
      Response response = await post(
        Uri.parse('${Config.apiLink}/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Successful'),
              content: const Text('Account Created Successfully! '),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => (const Login())),
                      (route) => false,
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Failed'),
              content: const Text('Please enter valid value'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connection Failed'),
            content: Text('Please connect wifi $e'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
              Hero(
                tag: 'vemdora icon',
                child: Image.asset('assets/images/vemdora_icon.png'),
              ),

              // welcome text
              Text(
                'Create account',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // email text field
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
                height: 10,
              ),

              // username text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // password text field
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
                height: 35,
              ),

              // Signup button
              BlueGradientButton(
                buttonText: 'Sign Up',
                onPress: () {
                  final bool isValid =
                      EmailValidator.validate(emailController.text.toString());
                  if (isValid) {
                    signup(
                      emailController.text.toString(),
                      usernameController.text.toString(),
                      passwordController.text.toString(),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sign Up Failed'),
                          content: const Text('Please enter the correct email'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
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
                      "Already have an account?",
                      style:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Login',
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
