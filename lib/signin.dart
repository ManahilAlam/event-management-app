import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart';
import 'register.dart'; // Import Register page for navigation
import 'createevent.dart'; // Import CreateEvent page for navigation

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailText = TextEditingController();
  final passText = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailText.dispose();
    passText.dispose();
    super.dispose();
  }

  /// Function to handle login
  Future<void> _login() async {
    String email = emailText.text.trim();
    String password = passText.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter both email and password.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Fetch user details from the database
      var user = await DBHelper.instance.getUser(email);

      if (!mounted) return; // Ensure widget is still in the tree

      if (user == null) {
        _showSnackBar("No account found with this email. Please sign up.");
      } else if (user['password'] == password) {
        _showSnackBar("Login successful!");

        // Navigate to the CreateEvent page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateEvent()),
        );
      } else {
        _showSnackBar("Incorrect password. Please try again.");
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false); // Ensure loading state is updated
      }
    }
  }

  /// Helper method to display SnackBar messages
  void _showSnackBar(String message) {
    // Use `mounted` to ensure context is valid
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCED4BE),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 40,
              top: 200,
              right: 10,
              bottom: 20,
            ),
            child: const Text(
              'Welcome\nBack.',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passText,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF3f6267),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF3f6267),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : IconButton(
                                color: Colors.white,
                                onPressed: _login,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _showSnackBar("Forgot Password? Contact support.");
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.teal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
