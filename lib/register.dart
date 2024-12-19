import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart'; // Import the DBHelper for database operations
import 'signin.dart'; // Import the SignIn page for navigation

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Function to add a user to the database
  Future<void> _registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validation checks
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar("All fields are required!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Check if the email already exists
      var existingUser = await DBHelper.instance.getUser(email);

      // Avoid using `context` directly if the widget is unmounted
      if (!mounted) return;

      if (existingUser != null) {
        _showSnackBar(
            "Email already registered. Please use a different email.");
      } else {
        // Add the user to the database
        bool isAdded =
            await DBHelper.instance.addUser(email: email, password: password);

        if (!mounted) return;

        if (isAdded) {
          _showSnackBar("Registration successful!");

          // Navigate to the SignIn page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        } else {
          _showSnackBar("Registration failed. Please try again.");
        }
      }
    } finally {
      // Ensure the loading state is updated even if an exception occurs
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Helper method to display SnackBar messages
  void _showSnackBar(String message) {
    // Ensure `context` usage is safe by checking `mounted`
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
          // Heading
          Container(
            padding: const EdgeInsets.only(left: 40, top: 150, right: 10),
            child: const Text(
              'Create\nAccount.',
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
                top: MediaQuery.of(context).size.height * 0.40,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
                  // Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Password Field
                  TextField(
                    controller: passwordController,
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

                  // Sign Up Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign Up',
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
                                onPressed: _registerUser,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Navigate to Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          );
                        },
                        child: const Text(
                          'Sign In',
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
          )
        ],
      ),
    );
  }
}
