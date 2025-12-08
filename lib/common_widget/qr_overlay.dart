// lib/common_widget/qr_overlay.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QROverlay extends StatelessWidget {
  final VoidCallback onClose;

  const QROverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(color: Colors.black.withOpacity(0.6)),
        ),

        // Центрт QR код
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Хаах товч
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40, bottom: 20),
                  child: GestureDetector(
                    onTap: onClose,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.close, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ),

              // QR карт
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      // QR код
                      QrImageView(
                        data:
                            "https://wolves.fitness/user/12345", // Та өөрчлөх боломжтой
                        version: QrVersions.auto,
                        size: 220,
                        backgroundColor: Colors.white,
                        errorCorrectionLevel: QrErrorCorrectLevel.H,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "WOLVES QR Код",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Гишvvнчлэлээ скан хийлгээрэй",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
