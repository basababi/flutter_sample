import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common/colo_extention.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ExerciseDetailPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final accent = TColor.primaryColor2 ?? const Color(0xFF7B4BFF);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      // Make body draw behind the status bar so the image can extend to top
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Fullscreen image (Hero for smooth transition)
            Positioned.fill(
              child: Hero(
                tag: imagePath,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, st) => Container(
                    color: const Color(0xFF222222),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white24,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Top gradient to make status icons readable
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 120,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
              ),
            ),

            // Back button and title (overlayed on the image)
            Positioned(
              top: 12,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  Material(
                    color: Colors.black45,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.6),
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom panel with description using Stack (semi-transparent card)
            Positioned(
              left: 12,
              right: 12,
              bottom: 16,
              child: Container(
                // Use a slightly transparent background so the image is visible under it
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + meta row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.timelapse, size: 14, color: accent),
                                const SizedBox(width: 6),
                                Text(
                                  '10 min',
                                  style: TextStyle(color: accent, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Description (scrollable if long)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 140),
                        child: SingleChildScrollView(
                          child: Text(
                            description,
                            style: const TextStyle(
                              color: Colors.white70,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Actions row
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Start exercise action
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: Text(
                                'Дасгалыг эхлүүлэх',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Material(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                // Add to favorites or save
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
