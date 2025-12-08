import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitness/view/login/login.dart';
import '../on_boarding/on_boarding_flow.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common_widget/round_buttom.dart';
import '../../common_widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool loading = false;

  void signUp() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final pass = passController.text;
    final confirm = confirmPassController.text;

    if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Бүх талбаруудыг бөглөнө үү")),
      );
      return;
    }

    if (pass != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Нууц үг таарахгүй байна")));
      return;
    }

    setState(() => loading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": pass}),
      );

      final data = jsonDecode(response.body);
      if (data["success"]) {
        // Амжилттай бүртгэл
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnBoardingFlow()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Бүртгэл амжилтгүй")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Алдаа гарлаа: $e")));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Та профайл хэсгийг бөглөнө үү",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              // TextFields...
              RoundTextField(
                controller: nameController,
                hitText: "Name",
                icon: "assets/img/user_text.png",
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: emailController,
                hitText: "Email or Phone",
                icon: "assets/img/email.png",
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: passController,
                hitText: "Password",
                icon: "assets/img/lock.png",
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: confirmPassController,
                hitText: "Confirm Password",
                icon: "assets/img/lock.png",
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginView()),
                        );
                      },
                      child: const Text(
                        "Буцах",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: RoundButtom(
                      title: loading ? "Хүлээх..." : "Sign Up",
                      onPressed: loading ? null : signUp,
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
