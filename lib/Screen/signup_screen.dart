import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_app/Helper/user_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() =>
      setState(() => _obscurePassword = !_obscurePassword);
  void _toggleConfirmPasswordVisibility() =>
      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      await UserManager.addUser(
        _emailController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration Successful")));

      Navigator.pop(context, {
        'email': _emailController.text,
        'password': _passwordController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white.withOpacity(0.96),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1B376B),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.alternate_email, color: Color(0xFF4285F4)),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Please enter your email";
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                              return "Enter a valid email";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Phone
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            prefixIcon: const Icon(Icons.phone, color: Color(0xFF4285F4)),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Please enter your phone number";
                            if (!RegExp(r'^[0-9]+$').hasMatch(value))
                              return "Phone number must be numeric";
                            if (value.length < 8)
                              return "Phone number must be at least 8 digits";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4285F4)),
                            filled: true,
                            fillColor: Colors.grey[100],
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
                            if (value == null || value.isEmpty)
                              return "Please enter your password";
                            if (value.length < 6)
                              return "Password must be at least 6 characters";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Confirm Password
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4285F4)),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[700],
                              ),
                              onPressed: _toggleConfirmPasswordVisibility,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Please confirm your password";
                            if (value != _passwordController.text)
                              return "Passwords do not match";
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
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
                            onPressed: _handleSignUp,
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}