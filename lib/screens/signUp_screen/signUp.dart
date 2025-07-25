import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/screens/signUp_screen/signUp_utils.dart';
import 'package:mess/screens/signUp_screen/signin_with_google.dart';

final passVisibilityProvider = StateProvider<bool>((ref) => false);

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final controller = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF81D4FA),
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF81D4FA),
                  Color(0xFFB3E5FC),
                  Color(0xFFE1F5FE),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 500 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_person,
                      size: 80,
                      color: Colors.lightBlueAccent,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Hi there!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    const Text('Sign Up to continue'),
                    const SizedBox(height: 10),
                    _buildInputField(
                      controller: controller,
                      hint: 'Email Address',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 10),
                    _buildInputField(
                      controller: passwordController,
                      hint: 'Enter a Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    _buildInputField(
                      controller: nameController,
                      hint: 'Enter your name',
                      icon: Icons.person,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildInputField(
                      controller: phoneController,
                      hint: 'Enter your phone number',
                      icon: Icons.phone_android,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await signUp(
                          email: controller.text,
                          password: passwordController.text,
                          context: context,
                          name: nameController.text,
                          phone: phoneController.text,
                        );
                        controller.clear();
                        passwordController.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(screenWidth * 0.5, 60),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        side: const BorderSide(
                            width: 1, color: Colors.lightBlueAccent), // border
                      ),
                      onPressed: () async {
                        await signInWithGoogle(context, ref);
                        Navigator.pushReplacementNamed(context, '/mainScreen');
                        controller.clear();
                        passwordController.clear();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 20,
                            child: Image.asset('assets/images/google.png'),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign Up with Google',
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildInputField extends ConsumerWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  const _buildInputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(passVisibilityProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.blueGrey.shade800),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.blueGrey.shade300),
          prefixIcon: Icon(icon, color: Colors.lightBlueAccent),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    ref.read(passVisibilityProvider.notifier).state =
                        !isPasswordVisible;
                  },
                  icon: !isPasswordVisible
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        ))
              : null,
        ),
      ),
    );
  }
}
