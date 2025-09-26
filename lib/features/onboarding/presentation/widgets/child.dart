import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/birthday.dart';

class ChildrenFormWidget extends StatefulWidget {
  List<Map<String, dynamic>> children;

  ChildrenFormWidget({Key? key, required this.children}) : super(key: key);

  @override
  State<ChildrenFormWidget> createState() => _ChildrenFormWidgetState();
}

class _ChildrenFormWidgetState extends State<ChildrenFormWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.children.isEmpty) {
      _addChild();
    }
  }

  void _addChild() {
    setState(() {
      widget.children.add({'name': '', 'birthday': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...(widget.children.isNotEmpty
            ? widget.children.asMap().entries.map((entry) {
                final index = entry.key;
                final child = entry.value;
                return _buildChildField(index, child);
              })
            : []),
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add Another Child"),
          onPressed: _addChild,
        ),
      ],
    );
  }

  Widget _buildChildField(int index, Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Child ${index + 1}'s Name"),
            onChanged: (val) {
              setState(() {
                child['name'] = val;
              });
            },
          ),
          const SizedBox(height: 10),
          Text("Child ${index + 1}'s Birthday:"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BirthdayInput(
              initialDate: child['birthday'].toString(),
              onDateSelected: (date) {
                setState(() {
                  child['birthday'] = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
