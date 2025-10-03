import 'package:flutter/material.dart';

class GuidanceModal extends StatefulWidget {
  const GuidanceModal({super.key});

  @override
  State<GuidanceModal> createState() => _GuidanceModalState();
}

class _GuidanceModalState extends State<GuidanceModal> {
  String? selectedFeeling;
  final TextEditingController meaningfulController = TextEditingController();
  final List<String> nextWeekFocus = [
    'Quality time with family',
    'Progress on adventure goal',
    'Connect with a friend',
    'Try something new',
  ];
  final Map<String, bool> checkedFocus = {};
  final List<String> suggestions = [
    'Call your grandmother',
    'Plan that camping trip',
    'Book your annual checkup',
  ];

  @override
  void initState() {
    super.initState();
    for (var focus in nextWeekFocus) {
      checkedFocus[focus] = false;
    }
  }

  @override
  void dispose() {
    meaningfulController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Weekly Life Check-In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      const Text(
                        '🤔 How was your week?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _feelingButton('😊 Great'),
                          _feelingButton('🙂 Good'),
                          _feelingButton('😐 Okay'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '💭 What made it meaningful?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: meaningfulController,
                        decoration: const InputDecoration(
                          hintText: 'Reflect on your week...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '🎯 Next week focus:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: nextWeekFocus.map((focus) {
                          return CheckboxListTile(
                            title: Text('☑ $focus'),
                            value: checkedFocus[focus],
                            onChanged: (value) {
                              setState(() {
                                checkedFocus[focus] = value ?? false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '💡 Personalized suggestions:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: suggestions.map((suggestion) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text('• $suggestion'),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Skip This Week'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Save the data and set reminders
                                Navigator.of(context).pop();
                              },
                              child: const Text('Set Reminders'),
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

  Widget _feelingButton(String feeling) {
    final isSelected = selectedFeeling == feeling;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFeeling = feeling;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(feeling),
    );
  }
}
