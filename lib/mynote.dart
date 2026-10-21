
import 'package:flutter/material.dart';
import 'package:mynote/profile.dart';
import 'addnote.dart';
import 'category.dart';

void main() {
  runApp(const mynote());
}

class mynote extends StatelessWidget {
  const mynote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyNotes',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF493BFF),
        ),
      ),
      home: const NotesScreen(),
      routes: {
        '/notes': (_) => const NotesScreen(),
        '/archive': (_) => const SimpleMenuScreen(
          title: 'Archive',
        ),
        '/settings': (_) => const SimpleMenuScreen(
          title: 'Settings',
        ),
        '/category-notes': (context) {
          final category =
              ModalRoute.of(context)?.settings.arguments as String? ??
                  'Personal';
          return CategoryNotesScreen(category: category);
        },
      },
    );
  }
}

const Color primary = Color(0xFF493BFF);

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, dynamic>> notes = [
    {
      'title': 'Meeting Notes',
      'subtitle': 'Discuss project timeline...',
      'date': '16 Oct',
      'icon': Icons.sticky_note_2,
      'color': const Color(0xFFFFC928),
      'bg': const Color(0xFFFFF4C5),
      'category': 'Work',
    },
    {
      'title': 'Shopping List',
      'subtitle': 'Milk, Bread, Fruits...',
      'date': '15 Oct',
      'icon': Icons.article,
      'color': const Color(0xFFB72BEA),
      'bg': const Color(0xFFF0D5FF),
      'category': 'Personal',
    },
    {
      'title': 'Travel Plan',
      'subtitle': 'Go trip planning...',
      'date': '14 Oct',
      'icon': Icons.flight_takeoff,
      'color': const Color(0xFF29B965),
      'bg': const Color(0xFFD5F8E0),
      'category': 'Personal',
    },
    {
      'title': 'Workout Routine',
      'subtitle': 'Gym schedule and diet...',
      'date': '12 Oct',
      'icon': Icons.fitness_center,
      'color': const Color(0xFF1684F8),
      'bg': const Color(0xFFD8EAFF),
      'category': 'Personal',
    },
    {
      'title': 'Book Ideas',
      'subtitle': 'New story concepts...',
      'date': '15 Oct',
      'icon': Icons.menu_book,
      'color': const Color(0xFFFF617C),
      'bg': const Color(0xFFFFE0E6),
      'category': 'Ideas',
    },
  ];

  Future<void> _openAddNote() async {
    final newNote = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddNoteScreen(),
      ),
    );

    if (!mounted) return;

    if (newNote != null) {
      setState(() {
        notes.insert(0, newNote);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note saved successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _openCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoriesScreen(),
      ),
    );
  }
  void _profile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      ),
    );
  }

  void _openDrawerPage(String title) {
    Navigator.pop(context);

    if (title == 'Home') return;

    if (title == 'Categories') {
      _openCategories();
      return;
    }
    if (title == 'profile') {
      _profile();
      return;
    }

    if (title == 'Logout') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout selected'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SimpleMenuScreen(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(12),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 112,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF5145FF),
                      Color(0xFF6355FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'H',
                        style: TextStyle(
                          color: primary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Virdiya hetvi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'hetvivirdiya@gmail.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _drawerItem(
                icon: Icons.home_rounded,
                title: 'Home',
                selected: true,
              ),
              _drawerItem(
                icon: Icons.grid_view_rounded,
                title: 'Categories',
              ),
              _drawerItem(
                icon: Icons.inventory_2_outlined,
                title: 'Archive',
              ),
              _drawerItem(
                icon: Icons.delete_outline_rounded,
                title: 'Trash',
              ),
              _drawerItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
              ),
              _drawerItem(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
              ),
              const Spacer(),
              const Divider(
                height: 1,
                color: Color(0xFFEDEDF2),
              ),
              const SizedBox(height: 12),
              _drawerItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                isLogout: true,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: primary,
                        size: 23,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'My',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 7),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: notes.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 0.7,
                  color: Color(0xFFF0F0F4),
                ),
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return SizedBox(
                    height: 59,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                              color: note['bg'] as Color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              note['icon'] as IconData,
                              color: note['color'] as Color,
                              size: 19,
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note['title'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF22232B),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  note['subtitle'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFF777985),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            note['date'] as String,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xFF858793),
                            ),
                          ),
                          PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            iconSize: 17,
                            icon: const Icon(
                              Icons.more_vert,
                              color: Color(0xFF565866),
                            ),
                            itemBuilder: (context) => const [],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 46,
        height: 46,
        child: FloatingActionButton(
          onPressed: _openAddNote,
          elevation: 4,
          backgroundColor: primary,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 27,
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Container(
        height: 52,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEDEDF2),
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const BottomItem(
              icon: Icons.home_rounded,
              label: 'Home',
              selected: true,
            ),
            InkWell(
              onTap: _openCategories,
              child: const BottomItem(
                icon: Icons.grid_view_rounded,
                label: 'Categories',
              ),
            ),
            InkWell(
              onTap: _openAddNote,
              child: const BottomItem(
                icon: Icons.add_circle_outline_rounded,
                label: 'Add',
              ),
            ),
        InkWell(
          onTap: _profile,
          child: const BottomItem(
          icon: Icons.person_outline_rounded,
          label: 'Profile',
        ),

        )],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    bool selected = false,
    bool isLogout = false,
  }) {
    final Color itemColor = isLogout
        ? const Color(0xFFFF3545)
        : selected
        ? primary
        : const Color(0xFF424657);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 1,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _openDrawerPage(title),
        child: Container(
          height: 29,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFECE9FF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: itemColor),
              const SizedBox(width: 13),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: itemColor,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// REUSABLE WIDGETS
// --------------------------------------------------

class CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;

  const CategoryChip({
    super.key,
    required this.title,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? primary : const Color(0xFFF2F3F8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 9,
          fontWeight:
          selected ? FontWeight.w600 : FontWeight.w400,
          color: selected ? Colors.white : const Color(0xFF454652),
        ),
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const BottomItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? primary : const Color(0xFF596176);

    return SizedBox(
      width: 65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: color,
              fontWeight:
              selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// SEARCH NOTES
// --------------------------------------------------

class NotesSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> notes;

  NotesSearchDelegate(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final filtered = notes.where((note) {
      return (note['title'] as String)
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          (note['subtitle'] as String)
              .toLowerCase()
              .contains(query.toLowerCase());
    }).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No notes found'));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final note = filtered[index];

        return ListTile(
          leading: Icon(
            note['icon'] as IconData,
            color: note['color'] as Color,
          ),
          title: Text(note['title'] as String),
          subtitle: Text(note['subtitle'] as String),
        );
      },
    );
  }
}

// --------------------------------------------------
// SIMPLE MENU SCREEN
// --------------------------------------------------

class SimpleMenuScreen extends StatelessWidget {
  final String title;

  const SimpleMenuScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// CATEGORY NOTES SCREEN
// --------------------------------------------------

class CategoryNotesScreen extends StatelessWidget {
  final String category;

  const CategoryNotesScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Notes in $category',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
