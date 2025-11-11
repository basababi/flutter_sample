import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/common_widget/round_buttom.dart';
import 'package:fitness/view/home/home_page.dart';

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

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

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
                keyboardType: TextInputType.emailAddress,
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
              RoundButtom(
                title: "Sign Up",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        name: nameController.text,
                        email: emailController.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
