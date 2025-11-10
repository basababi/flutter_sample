import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final EdgeInsets? margin;
  final bool obscureText;

  const RoundTextField({
    super.key,
    this.controller,
    this.keyboardType,
    required this.hitText,
    required this.icon,
    this.margin,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          border: InputBorder.none,
          hintText: hitText,
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
