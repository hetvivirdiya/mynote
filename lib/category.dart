
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Personal',
      'count': 12,
      'icon': Icons.article_outlined,
      'color': Color(0xFFF16B86),
      'bg': Color(0xFFFFF0F4),
    },
    {
      'name': 'Work',
      'count': 8,
      'icon': Icons.work_outline,
      'color': Color(0xFF1683F8),
      'bg': Color(0xFFEDF6FF),
    },
    {
      'name': 'Ideas',
      'count': 6,
      'icon': Icons.lightbulb,
      'color': Color(0xFFFFC928),
      'bg': Color(0xFFFFF9E8),
    },
    {
      'name': 'Shopping',
      'count': 5,
      'icon': Icons.shopping_cart,
      'color': Color(0xFF39B968),
      'bg': Color(0xFFECFBF1),
    },
    {
      'name': 'Travel',
      'count': 4,
      'icon': Icons.flight,
      'color': Color(0xFF7950F2),
      'bg': Color(0xFFF3F0FF),
    },
    {
      'name': 'Others',
      'count': 3,
      'icon': Icons.grid_view_rounded,
      'color': Color(0xFF087FF5),
      'bg': Color(0xFFEDF6FF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFD),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF222222),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/category-notes',
                  arguments: category['name'],
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: category['bg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'],
                      size: 31,
                      color: category['color'],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${category['count']} Notes',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
