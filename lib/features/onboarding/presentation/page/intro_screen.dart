import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/colors.dart';
import 'package:life_tracking/core/class/local_storage.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/text.dart';
import 'package:life_tracking/core/widgets/custom_text_field.dart';
import 'package:life_tracking/features/onboarding/presentation/func/onborading_view.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/animation_dots.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/birthday.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/relationshipPage.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/select_intersting.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/slider_age.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();

  String name = "";
  String selectedBirthday = '';
  int selectedAge = 90;
  String relationship = "";
  String haveChildren = "";

  List<String> selectedGoals = [];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getSlides() => [
    {
      'title': '👋 Hi there!',
      'subtitle': 'Welcome to Life Tracker',
      'body': _buildText(
        "We're going to help you make every moment truly count",
      ),
    },
    {
      'title': 'What should we call you?',
      'body': CustomTextField(
        controller: _nameController,
        hint: "Your first name...",
        hintStyle: TextStyle(color: AppColors.black),
        onChanged: (val) => setState(() => name = val),
      ),
    },
    {
      'title': 'Nice to meet you ${name.isNotEmpty ? name : "my friend"}',
      'subtitle': 'When were you born?',
      'body': Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BirthdayInput(
          initialDate: selectedBirthday,
          onDateSelected: (date) => setState(() => selectedBirthday = date),
        ),
      ),
    },
    {
      'title': "Here's our philosophy...",
      'subtitle': "We focus on remaining time,\nnot what's already passed.",
      'body': AnimatedDots(
        totalDots: 9,
        duration: const Duration(milliseconds: 400),
      ),
    },
    {
      'title':
          "How long do you plan to,\n${name.isNotEmpty ? name : "my friend"}? 😄",
      'subtitle': 'Monitor relationships, adventures, and share achievements.',
      'body': Padding(
        padding: const EdgeInsets.all(20),
        child: AgeSlider(
          onAgeChanged: (age) => setState(() => selectedAge = age),
        ),
      ),
      'subBody': "💡 This is just for planning (you can change it later).",
    },
    {
      'title': "👥 Do you have a partner or spouse, $name?",
      'body': RelationshipInput(
        options: [
          "Yes, I'm in a relationship",
          "No, I'm single",
          "It's complicated 😅",
        ],
        initialOption: relationship,
        onOptionSelected: (value) => setState(() => relationship = value),
      ),
    },
    {
      'title': "👶 Do you have kids?",
      'body': RelationshipInput(
        options: [
          "Yes! They're my world",
          "Not yet, but planning to",
          "No, and no plans to",
        ],
        initialOption: haveChildren,
        onOptionSelected: (value) => setState(() => haveChildren = value),
      ),
    },

    {
      'title': "✨ What excites you most about life, $name?",
      'subtitle': "Select all that call to you:",
      'body': Padding(
        padding: const EdgeInsets.all(16.0),
        child: GoalsInput(
          initialOptions: selectedGoals,
          onOptionsSelected: (options) =>
              setState(() => selectedGoals = options),
        ),
      ),
    },
    {
      'title': "🎉 Perfect, $name!",
      'subtitle': "We've created your personal life tracking dashboard",
      'body': const Text("Ready to make every moment count?"),
    },
  ];

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = getSlides();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.pri, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: slides.length,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: AppColor.background,
                    activeDotColor: AppColor.subtitle,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: slides.length,
                    itemBuilder: (context, index) =>
                        _buildSlide(slides[index], index, slides.length),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(Map<String, dynamic> slide, int index, int totalSlides) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitle(slide),
                  if (slide.containsKey('subtitle') &&
                      slide['subtitle'] != null)
                    _buildSubtitle(slide['subtitle']),
                  const SizedBox(height: 20),
                  if (slide.containsKey('body') && slide['body'] is Widget)
                    slide['body'] as Widget
                  else
                    const SizedBox.shrink(),
                  if (slide.containsKey('subBody') && slide['subBody'] != null)
                    _buildSubBody(slide['subBody']),
                  const Spacer(),
                  _buildNavigationButtons(index, totalSlides),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Map<String, dynamic> slide) {
    return Text(
      slide['title']?.toString() ?? "",
      textAlign: TextAlign.center,
      style: Styles.titleStyle,
    );
  }

  Widget _buildSubtitle(String? subtitle) {
    if (subtitle == null || subtitle.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: Styles.subtitleStyle,
      ),
    );
  }

  Widget _buildSubBody(String? subBody) {
    if (subBody == null || subBody.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        subBody,
        textAlign: TextAlign.center,
        style: Styles.bodyStyle,
      ),
    );
  }

  Widget _buildNavigationButtons(int index, int totalSlides) {
    return Column(
      children: [
        if (index == totalSlides - 1) ...[
          _buildButton(text: "Let's begin! 🚀", onPressed: _onFinish),
          SizedBox(height: 10.h),
          // _buildButton(
          //   text: "Skip this question",
          //   onPressed: _onFinish,
          //   isOutlined: true,
          // ),
        ] else
          _buildButton(text: "Next", onPressed: () => _goToNext(index)),
        if (index != 0)
          Column(
            children: [
              SizedBox(height: 20.h),
              _buildButton(
                isOutlined: true,
                text: "Back",
                onPressed: () => _pageController.animateToPage(
                  index - 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _goToNext(int index) {
    if (index == 1 && name.trim().isEmpty) {
      _showSnackBar("⚠️ Please enter your name");
      return;
    }
    if (index == 2 && selectedBirthday.isEmpty) {
      _showSnackBar("⚠️ Please select your birthday");
      return;
    }
    _pageController.animateToPage(
      index + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onFinish() async {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar("⚠️ Name is required");
      return;
    }
    if (selectedBirthday.isEmpty) {
      _showSnackBar("⚠️ Birthday is required");
      return;
    }

    await LocalStorage.saveUserData(
      name: _nameController.text.trim(),
      birthday: selectedBirthday,
      lifeExpectancy: selectedAge,
      relationship: relationship,
      goals: selectedGoals,
      haveChildren: haveChildren, // جديد
    );

    setOnboardingSeen();
    Navigator.pushReplacementNamed(context, AppRouts.login);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.white : AppColors.pri,
          foregroundColor: isOutlined ? AppColors.pri : Colors.white,
          side: isOutlined
              ? BorderSide(color: AppColors.pri, width: 1.5)
              : BorderSide.none,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: Styles.buttonText),
      ),
    );
  }
}
