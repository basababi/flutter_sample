import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common/colo_extention.dart';
import 'exercise_detail.dart';

class PilatesPage extends StatefulWidget {
  const PilatesPage({super.key});

  @override
  State<PilatesPage> createState() => _PilatesPageState();
}

class _PilatesPageState extends State<PilatesPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0;

  final List<String> _tabs = ['Бие халаалт', 'Core', 'Flexibility', 'Бүрэн'];

  final Map<int, List<Map<String, String>>> _itemsByTab = {
    0: [
      {
        'image': 'assets/img/pilates_warm1.jpg',
        'title': 'Халаалт 1',
        'description': 'Хөнгөн сунгалт ба амжилттай байрлалтай бэлтгэл.',
      },
      {
        'image': 'assets/img/pilates_warm2.jpg',
        'title': 'Халаалт 2',
        'description': 'Амьсгалын болон үндэсний хөдөлгөөн.',
      },
    ],
    1: [
      {
        'image': 'assets/img/pilates_core1.jpg',
        'title': 'Hundred',
        'description': 'Core хүчийг сайжруулах үндсэн Pilates дасгал.',
      },
      {
        'image': 'assets/img/pilates_core2.jpg',
        'title': 'Roll Up',
        'description': 'Абдоминал булчинд төвлөрсөн сунгалт.',
      },
    ],
    2: [
      {
        'image': 'assets/img/pilates_flex1.jpg',
        'title': 'Spine Stretch',
        'description': 'Мөр, нурууны уян хатан байдлыг нэмэх дасгал.',
      },
    ],
    3: [
      {
        'image': 'assets/img/pilates_full1.jpg',
        'title': 'Full Routine',
        'description': '30 минутын бүрэн Pilates хөтөлбөр.',
      },
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  List<Map<String, String>> _filteredItems(List<Map<String, String>> items) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items
        .where(
          (it) =>
              (it['title'] ?? '').toLowerCase().contains(query) ||
              (it['description'] ?? '').toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFF222222);
    final cardBg = Colors.white;
    final accent = TColor.primaryColor2;
    final items = _itemsByTab[_selectedTab] ?? [];
    final visibleItems = _filteredItems(items);

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
                  itemCount: visibleItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    final item = visibleItems[index];
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
