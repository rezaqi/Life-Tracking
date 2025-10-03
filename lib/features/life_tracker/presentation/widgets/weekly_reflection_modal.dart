import 'package:flutter/material.dart';

class WeeklyReflectionModal extends StatefulWidget {
  const WeeklyReflectionModal({super.key});

  @override
  State<WeeklyReflectionModal> createState() => _WeeklyReflectionModalState();
}

class _WeeklyReflectionModalState extends State<WeeklyReflectionModal>
    with TickerProviderStateMixin {
  String? selectedFeeling;
  final TextEditingController gratefulController = TextEditingController();
  final TextEditingController nextWeekController = TextEditingController();
  final List<String> quickWins = [
    'Call a family member',
    'Try something new',
    'Spend time outdoors',
    'Work on an adventure goal',
  ];
  final Map<String, bool> checkedWins = {};

  late AnimationController _modalAnimationController;
  late Animation<double> _modalScaleAnimation;
  late Animation<double> _modalFadeAnimation;

  late AnimationController _entranceAnimationController;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _feelingFadeAnimation;
  late Animation<double> _gratefulFadeAnimation;
  late Animation<double> _nextWeekFadeAnimation;
  late Animation<double> _quickWinsFadeAnimation;
  late Animation<double> _buttonsFadeAnimation;

  @override
  void initState() {
    super.initState();
    for (var win in quickWins) {
      checkedWins[win] = false;
    }

    _modalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _modalScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _modalAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    _modalFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _modalAnimationController, curve: Curves.easeIn),
    );

    _entranceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    _feelingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.1, 0.4, curve: Curves.easeIn),
      ),
    );

    _gratefulFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );

    _nextWeekFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );

    _quickWinsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _buttonsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceAnimationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _modalAnimationController.forward().then((_) {
      _entranceAnimationController.forward();
    });
  }

  @override
  void dispose() {
    gratefulController.dispose();
    nextWeekController.dispose();
    _modalAnimationController.dispose();
    _entranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _modalFadeAnimation,
      child: ScaleTransition(
        scale: _modalScaleAnimation,
        child: Dialog(
          elevation: 12,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeTransition(
                            opacity: _titleFadeAnimation,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Weekly Check-In',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 24),
                          FadeTransition(
                            opacity: _feelingFadeAnimation,
                            child: Column(
                              children: [
                                const Text(
                                  '🤔',
                                  style: TextStyle(fontSize: 40),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'How did this week feel?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: quickWins
                                      .map((win) => _feelingButton(win))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _gratefulFadeAnimation,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'What are you most grateful for?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: gratefulController,
                                  decoration: InputDecoration(
                                    hintText: 'This week I\'m grateful for...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _nextWeekFadeAnimation,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'How can you make next week more meaningful?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: nextWeekController,
                                  decoration: InputDecoration(
                                    hintText: 'Next week I want to...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _quickWinsFadeAnimation,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Quick wins for next week:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: quickWins.map((win) {
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      curve: Curves.easeInOut,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: checkedWins[win]!
                                            ? Colors.blue.withOpacity(0.1)
                                            : Colors.transparent,
                                      ),
                                      child: CheckboxListTile(
                                        title: Text(
                                          win,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        value: checkedWins[win],
                                        onChanged: (value) {
                                          setState(() {
                                            checkedWins[win] = value ?? false;
                                          });
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding: EdgeInsets.zero,
                                        activeColor: Colors.blue,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _buttonsFadeAnimation,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      'Skip',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: Save the data
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text('Save & Plan'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _feelingButton(String feeling) {
    final isSelected = selectedFeeling == feeling;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..scale(isSelected ? 1.05 : 1.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedFeeling = feeling;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: isSelected ? 4 : 0,
          shadowColor: Colors.blue.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        child: Text(feeling, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
