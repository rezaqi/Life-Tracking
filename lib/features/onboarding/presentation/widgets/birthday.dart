import 'package:flutter/material.dart';

class BirthdayInput extends StatefulWidget {
  final void Function(String) onDateSelected;
  final String? initialDate; // 👈 قيمة أولية

  const BirthdayInput({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  State<BirthdayInput> createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
      try {
        _selectedDate = DateTime.parse(widget.initialDate!);
      } catch (e) {
        debugPrint("Invalid date format: ${widget.initialDate}");
      }
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.onDateSelected(
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: "your birthday",
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          controller: TextEditingController(
            text: _selectedDate == null
                ? ""
                : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
          ),
        ),
      ),
    );
  }
}
