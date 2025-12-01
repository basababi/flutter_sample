import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common/colo_extention.dart';
import 'exercise_detail.dart';

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 1;

  final List<String> _tabs = ['Бие халаалт', 'Цээж', 'Нуруу', 'Хөл', 'Мөр'];

  // Example items for each tab (replace with your real assets & text)
  final Map<int, List<Map<String, String>>> _itemsByTab = {
    0: [
      {
        'image': 'assets/img/ex1.jpg',
        'title': 'Халаалт 1',
        'description':
            '10 минутын халаалт: суулт, мөрний сунгалт, гараа эргүүлэлт.',
      },
      {
        'image': 'assets/img/ex2.jpg',
        'title': 'Халаалт 2',
        'description': 'Дулаахан алхалт, хөнгөн кардио.',
      },
    ],
    1: [
      {
        'image': 'assets/img/chest1.jpg',
        'title': 'Chest Fly',
        'description': 'Chest fly — цээжийн булчинд зориулсан дасгал.',
      },
      {
        'image': 'assets/img/chest2.jpg',
        'title': 'Bench Press',
        'description': 'Bench press — цээж болон трицепсийг хөгжүүлэх дасгал.',
      },
    ],
    2: [
      {
        'image': 'assets/img/back1.jpg',
        'title': 'Lat Pulldown',
        'description': 'Lat pulldown — нуруу, далны өргөнийг хөгжүүлэх дасгал.',
      },
    ],
    3: [
      {
        'image': 'assets/img/leg1.jpg',
        'title': 'Squat',
        'description':
            'Squat — хөл, бэлхүүс, өгзөгийг хөгжүүлэх үндсэн дасгал.',
      },
    ],
    4: [
      {
        'image': 'assets/img/shoulder1.jpg',
        'title': 'Shoulder Press',
        'description': 'Shoulder press — мөрний дээд хэсгийг хөгжүүлэх дасгал.',
      },
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // When a grid item is tapped, open the ExerciseDetailPage and pass data.
  void _openDetail(Map<String, String> item) {
    final image = item['image'] ?? '';
    final title = item['title'] ?? '';
    final description = item['description'] ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseDetailPage(
          imagePath: image,
          title: title,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFF222222);
    final cardBg = Colors.white;
    final accent = TColor.primaryColor2 ?? const Color(0xFF7B4BFF);
    final items = _itemsByTab[_selectedTab] ?? [];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Дасгалууд',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search box
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        child: const Icon(Icons.clear, color: Colors.white54),
                      ),
                  ],
                ),
              ),
            ),

            // Tabs row
            SizedBox(
              height: 52,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: List.generate(_tabs.length, (index) {
                    final selected = index == _selectedTab;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTab = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _tabs[index],
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.white70,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 3,
                              width: selected ? 28 : 0,
                              decoration: BoxDecoration(
                                color: selected ? accent : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Exercises grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final imagePath = item['image'] ?? '';
                    final title = item['title'] ?? '';

                    return GestureDetector(
                      onTap: () => _openDetail(item),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: imagePath,
                                  child: Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, stack) =>
                                        Container(
                                          color: const Color(0xFFEEEEEE),
                                          child: const Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 14, 0, 86),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
