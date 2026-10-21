
import 'package:flutter/material.dart';

const Color primary = Color(0xFF493BFF);

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController noteController =
  TextEditingController();

  String selectedCategory = 'Personal';
  bool reminderEnabled = false;
  int selectedColorIndex = 3;

  final List<Color> noteColors = const [
    Color(0xFFFFE36E),
    Color(0xFFFFD2DE),
    Color(0xFFE4B5FF),
    Color(0xFF493BFF),
    Color(0xFF9BE8A5),
  ];

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a note title'),
        ),
      );
      return;
    }

    final selectedColor = noteColors[selectedColorIndex];
    final now = DateTime.now();

    final newNote = <String, dynamic>{
      'title': title,
      'subtitle':
      content.isEmpty ? 'No description' : content,
      'date': '${now.day} ${_monthName(now.month)}',
      'icon': Icons.sticky_note_2_rounded,
      'color': selectedColorIndex == 3
          ? Colors.white
          : const Color(0xFF454652),
      'bg': selectedColor,
      'category': selectedCategory,
      'reminder': reminderEnabled,
      'content': content,
    };

    Navigator.pop(context, newNote);
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 17,
            color: Color(0xFF252631),
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          'Add Note',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF22232B),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(
              Icons.check_rounded,
              color: Color(0xFF252631),
              size: 22,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel('Title'),
              const SizedBox(height: 5),
              TextField(
                controller: titleController,
                textCapitalization:
                TextCapitalization.sentences,
                decoration:
                _inputDecoration('Enter note title...'),
              ),
              const SizedBox(height: 14),

              const _FieldLabel('Category'),
              const SizedBox(height: 5),
              Container(
                height: 34,
                padding:
                const EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  border: Border.all(
                    color: const Color(0xFFE5E7EF),
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF30313A),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Personal',
                        child: Text('Personal'),
                      ),
                      DropdownMenuItem(
                        value: 'Work',
                        child: Text('Work'),
                      ),
                      DropdownMenuItem(
                        value: 'Ideas',
                        child: Text('Ideas'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const _FieldLabel('Note'),
              const SizedBox(height: 5),
              TextField(
                controller: noteController,
                maxLines: 5,
                minLines: 5,
                textCapitalization:
                TextCapitalization.sentences,
                decoration: _inputDecoration(
                  'Write your note here...',
                ).copyWith(
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 13),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 15,
                    color: Color(0xFF343640),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Set Reminder',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF30313A),
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: reminderEnabled,
                      activeThumbColor: Colors.white,
                      activeTrackColor: primary,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor:
                      const Color(0xFFCBD1DD),
                      trackOutlineColor:
                      const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      onChanged: (value) {
                        setState(() {
                          reminderEnabled = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              const _FieldLabel('Color'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: List.generate(
                  noteColors.length,
                      (index) {
                    final selected =
                        selectedColorIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColorIndex = index;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: noteColors[index],
                          shape: BoxShape.circle,
                        ),
                        child: selected
                            ? const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: Colors.white,
                        )
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 43,
                child: ElevatedButton(
                  onPressed: _saveNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Note',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xFF9296A3),
      ),
      filled: true,
      fillColor: const Color(0xFFF5F6FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EF),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: primary,
          width: 1,
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF30313A),
      ),
    );
  }
}
