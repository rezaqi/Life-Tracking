import 'package:flutter/material.dart';

class GoalsInput extends StatefulWidget {
  final void Function(List<String>) onOptionsSelected;
  final List<String>? initialOptions;

  const GoalsInput({
    super.key,
    required this.onOptionsSelected,
    this.initialOptions,
  });

  @override
  State<GoalsInput> createState() => _GoalsInputState();
}

class _GoalsInputState extends State<GoalsInput> {
  final List<String> _options = [
    "Family & relationships",
    "Adventures & experiences",
    "Learning & growth",
    "Health & wellness",
    "Career & achievement",
    "Giving back & legacy",
  ];

  late Set<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.initialOptions?.toSet() ?? {};
  }

  void _toggleOption(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
    });

    widget.onOptionsSelected(_selectedOptions.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _options.map((option) {
        final isSelected = _selectedOptions.contains(option);

        return GestureDetector(
          onTap: () => _toggleOption(option),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
