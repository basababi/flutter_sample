import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';

enum RoundButtomType { bgGradient, textGradient }

class RoundButtom extends StatelessWidget {
  final String title;
  final RoundButtomType type;
  // Allow synchronous or asynchronous callbacks and also allow null for disabled state
  final FutureOr<void> Function()? onPressed;

  const RoundButtom({
    super.key,
    required this.title,
    this.type = RoundButtomType.textGradient,
    this.onPressed,
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
                  offset: Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: MaterialButton(
        // MaterialButton.onPressed expects a void callback. Provide a wrapper that calls the
        // (possibly async) callback and ignores the returned Future, while still allowing
        // error handling/logging if desired.
        onPressed: onPressed == null
            ? null
            : () {
                try {
                  final result = onPressed!();
                  if (result is Future) {
                    // Prevent unhandled exceptions from bubbling up; optionally handle them.
                    result.catchError((e, st) {
                      // You can replace debugPrint with your logging solution.
                      debugPrint('RoundButtom callback error: $e\n$st');
                    });
                  }
                } catch (e, st) {
                  debugPrint('RoundButtom callback sync error: $e\n$st');
                }
              },
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
