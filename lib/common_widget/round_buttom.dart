import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';

enum RoundButtomType { bgGradient, textGradient }

class RoundButtom extends StatelessWidget {
  final String title;
  final RoundButtomType type;
  final VoidCallback onPressed;
  const RoundButtom({
    super.key,
    required this.title,
    this.type = RoundButtomType.textGradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: TColor.primaryGradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: type == RoundButtomType.bgGradient
            ? [
                const BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: type == RoundButtomType.bgGradient
            ? Colors.transparent
            : TColor.whiteColor,
        elevation: type == RoundButtomType.bgGradient ? 0 : 1,

        child: type == RoundButtomType.bgGradient
            ? Text(
                title,
                style: TextStyle(
                  color: TColor.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            : ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    LinearGradient(
                      colors: TColor.secondaryGradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),

                child: Text(
                  title,

                  style: TextStyle(
                    color: TColor.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ),
    );
  }
}
