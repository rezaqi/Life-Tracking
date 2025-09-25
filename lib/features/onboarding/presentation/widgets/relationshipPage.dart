import 'package:flutter/material.dart';

class RelationshipInput extends StatefulWidget {
  final void Function(String) onOptionSelected;
  final String? initialOption;
  final List<String> options;
  const RelationshipInput({
    super.key,
    required this.onOptionSelected,
    this.initialOption,
    required this.options,
  });

  @override
  State<RelationshipInput> createState() => _RelationshipInputState();
}

class _RelationshipInputState extends State<RelationshipInput> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  void _pickOption(String option) {
    setState(() {
      _selectedOption = option;
    });
    widget.onOptionSelected(option); // تبعت القيمة للصفحة الأم
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        final isSelected = _selectedOption == option;

        return GestureDetector(
          onTap: () => _pickOption(option),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
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
