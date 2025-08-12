import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/service/authentication.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isloading = false;
  bool isobsure1 = true;
  bool isobsure2 = true;

  void toggle(int id) {
    if (id == 1) {
      isobsure1 = !isobsure1;
    } else {
      isobsure2 = !isobsure2;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
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
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                  style: GoogleFonts.poppins(),
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Contact No.',
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
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    }
                    if (value.length < 10) {
                      return 'Contact number must be 10 digit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: companyController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Company',
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
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: isobsure1,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        toggle(1);
                      },
                      icon: Icon(isobsure1 ? Icons.visibility_off_outlined : Icons.visibility),
                    ),
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
                  style: const TextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: isobsure2,
                  controller: confirmPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        toggle(2);
                      },
                      icon: Icon(isobsure2 ? Icons.visibility_off_outlined : Icons.visibility),
                    ),
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
                  style: const TextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: notesController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Notes if any,',
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
                  style: GoogleFonts.poppins(),
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
                              try {
                                final UserCredential? user =
                                    await Authentication.signUpWithEmailAndPassword(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text,
                                      companyController.text,
                                      notesController.text,
                                      passwordController.text,
                                    );
                                if (user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      elevation: 5.0,
                                      behavior: SnackBarBehavior.floating,
                                      padding: const EdgeInsets.all(10.0),
                                      content: Text(
                                        'Sign up successful!',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 5.0,
                                    behavior: SnackBarBehavior.floating,
                                    padding: const EdgeInsets.all(10.0),
                                    content: Text(
                                      '$error',
                                      style: GoogleFonts.poppins(fontSize: 16.0),
                                    ),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  isloading = false;
                                });
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
                              'Sign Up',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an Account?",
                      style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
