import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/Helper/user_manager.dart';
import 'package:pos_app/Screen/signup_screen.dart';
import 'package:pos_app/Screen/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Store registered credentials
  static String? registeredEmail;
  static String? registeredPassword;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      bool valid = await UserManager.validateUser(_emailController.text, _passwordController.text);

      if (valid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(email: _emailController.text),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Invalid email or password"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4285F4),
              Color(0xFF2A6FD1),
              Color(0xFF1B376B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or App Icon Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.lock_outline, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 32),

                  // Login Card
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    color: Colors.white.withOpacity(0.93),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              "Welcome Back!",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF1B376B),
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Sign in to continue",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                filled: true,
                                fillColor: Colors.grey[100],
                                prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1B376B)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Please enter your email";
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                filled: true,
                                fillColor: Colors.grey[100],
                                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1B376B)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Please enter your password";
                                if (value.length < 6) return "Password must be at least 6 characters";
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4285F4),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: _handleLogin,
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Divider
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "or",
                                    style: GoogleFonts.poppins(color: Colors.grey[500]),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Social login placeholder (optional, can add your own)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.g_mobiledata, color: Color(0xFF4285F4), size: 32),
                                  onPressed: () {}, // Add Google login
                                ),
                                IconButton(
                                  icon: const Icon(Icons.apple, color: Colors.black, size: 32),
                                  onPressed: () {}, // Add Apple login
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                          if (result != null && result is Map<String, String>) {
                            setState(() {
                              _emailController.text = result['email'] ?? '';
                              _passwordController.text = result['password'] ?? '';
                              registeredEmail = result['email'];
                              registeredPassword = result['password'];
                            });
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}