import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/service/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isloading = false;
  bool isobsure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Messenger',
                    style: GoogleFonts.poppins(fontSize: 36.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.secondary),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: isobsure,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: TextStyle(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isobsure = !isobsure;
                      });
                    },
                    icon: Icon(isobsure ? Icons.visibility_off_outlined : Icons.visibility),
                  ),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: isloading
                    ? Center(child: CircularProgressIndicator())
                    : FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              isloading = true;
                            });
                            final UserCredential? user =
                                await Authentication.signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                            if (user != null) {
                              setState(() {
                                isloading = false;
                              });
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                            } else {
                              setState(() {
                                isloading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 5.0,
                                  behavior: SnackBarBehavior.floating,
                                  padding: const EdgeInsets.all(10.0),
                                  content: Text(
                                    'Something went wrong. Please try again.',
                                    style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.red),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          foregroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
