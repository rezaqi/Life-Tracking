import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/colors.dart';
import 'package:life_tracking/core/class/local_storage.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/text.dart';
import 'package:life_tracking/core/class/validator.dart';
import 'package:life_tracking/core/widgets/custom_text_field.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_event.dart';
import 'package:life_tracking/features/auth/presentation/bloc/auth_state.dart';
import 'package:life_tracking/features/dashboard/const/countries.dart';
import 'package:life_tracking/features/onboarding/presentation/func/onborading_view.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/animation_dots.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/birthday.dart';
import 'package:life_tracking/features/onboarding/presentation/widgets/child.dart';
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
  final TextEditingController _namePartner = TextEditingController();
  TextEditingController _childController = TextEditingController();

  final TextEditingController _nameChild = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = "";
  String selectedBirthday = '';
  String selectedBirthdayPartner = '';
  String selectedBirthdayChild = '';
  String selectedAnniversaryPartner = '';
  int selectedAge = 90;
  String relationship = "";
  String haveChildren = "";
  String? countryName;
  List<String> selectedGoals = [];
  List<Map<String, dynamic>> children = [];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _namePartner.dispose();
    _nameChild.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getSlides() => [
    // 1 welcome
    {
      'title': '👋 Welcome to',
      'subtitle': ''''Life Tracker Make every moment count 
''',
      'body': Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 30.h,
        children: [
          _buildButton(
            text: "🚀 Get Started ",
            onPressed: () {
              _goToNext(0);
            },
          ),
          _buildButton(
            isOutlined: true,
            text: " Sign In  ",
            onPressed: () {
              Navigator.pushNamed(context, AppRouts.login);
            },
          ),
        ],
      ),
    },
    // 3 lets go
    {
      'title': " Let's personalize your life journey!",
      'subtitle': """We'll ask a few questions to create your dashboard 
""",
      'body': '',
    },
    //4 name
    {
      'title': 'What should we call you?',
      'body': CustomTextField(
        controller: _nameController,
        hint: "Your first name...",
        hintStyle: TextStyle(color: AppColors.black),
        onChanged: (val) => setState(() => name = val),
      ),
    },

    // 5 born
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
    //6 live
    {
      'title': """Just a couple more details to personalize your life journey..
""",
      'subtitle': " Where do you live?",
      'body': Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: DropdownButton<String>(
          value: countryName,
          hint: Text('Select Country'),
          items: countries
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => setState(() => countryName = val),
        ),
      ),
    },
    // 7 philosophy
    {
      'title': "Here's our philosophy...",
      'subtitle': "We focus on remaining time,\nnot what's already passed.",
      'body': AnimatedDots(
        totalDots: 14,
        duration: const Duration(milliseconds: 400),
      ),
    },

    // 8 lifeEx
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
    // 9 relationship
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
    //10 Partner
    {
      'title': "Great! Let's add them. This helps track your time  together.",
      'body': Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(controller: _namePartner, hint: "Partner's Name"),
          SizedBox(height: 10.h),
          Text("Their Birthday:"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BirthdayInput(
              initialDate: selectedBirthdayPartner,
              onDateSelected: (date) =>
                  setState(() => selectedBirthdayPartner = date),
            ),
          ),
          Text("Your Anniversary (optional):"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BirthdayInput(
              initialDate: selectedAnniversaryPartner,
              onDateSelected: (date) =>
                  setState(() => selectedAnniversaryPartner = date),
            ),
          ),
        ],
      ),
    },
    // 11 kid
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
    //12 add kid
    {
      'title':
          " 👨‍👩‍👧‍👦 Wonderful! Adding them helps make every moment count",
      'body': Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ChildrenFormWidget(children: children)],
      ),
    },
    // 13 intersting
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

    // 2 create account
    {
      'title': "Create Your Account",
      'subtitle': "Let's secure your journey",
      'body': Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              validator: Validators.email,

              controller: emailController,
              hint: "email",
            ),
            const SizedBox(height: 12),
            CustomTextField(
              validator: Validators.password,

              controller: passwordController,
              hint: "password",
              obscure: true,
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(value: false, onChanged: (val) {}),
                const Expanded(
                  child: Text(
                    "I agree to the Terms of Service and Privacy Policy",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildButton(
              icon: Icons.g_mobiledata_sharp,
              isOutlined: true,
              text: "Continue with Google",
              onPressed: () {},
            ),
            SizedBox(height: 20),
            _buildButton(
              icon: Icons.apple_sharp,
              color: Colors.black,
              text: "Continue with Apple",
              onPressed: () {},
            ),

            //    CreateAccountFooter(),
          ],
        ),
      ),
    },

    // 14 done
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
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.requestStateSignUp == RequestState.loading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        // لو مش لودنق نقفل أي Dialog مفتوح
                        Navigator.of(context, rootNavigator: true).pop();

                        if (state.requestStateSignUp == RequestState.success) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else if (state.requestStateSignUp ==
                            RequestState.error) {
                          _showSnackBar(
                            state.failureSignUp?.message ?? "Signup failed",
                          );
                        }
                      }
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: slides.length,
                      itemBuilder: (context, index) =>
                          _buildSlide(slides[index], index, slides.length),
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
                  slide.containsKey('body') && slide['body'] is Widget
                      ? slide['body'] as Widget
                      : const SizedBox.shrink(),

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
        if (index == 0)
          ...[]
        else if (index == 2) ...[
          _buildButton(text: "Let's Go! 🚀", onPressed: () => _goToNext(index)),
        ] else if (index == totalSlides - 1) ...[
          _buildButton(text: "Enter Dashboard 🚀", onPressed: _onFinish),
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

  void _goToNext(int index) async {
    if (index == 2 && name.trim().isEmpty) {
      _showSnackBar("⚠️ Please enter your name");
      return;
    }
    if (index == 3 && selectedBirthday.isEmpty) {
      _showSnackBar("⚠️ Please select your birthday");
      return;
    }
    if (index == 4 && countryName == null) {
      _showSnackBar("⚠️ Please select your Country");
      return;
    }
    if (index == 7 && relationship != "Yes, I'm in a relationship") {
      if (!mounted) return;
      _pageController.animateToPage(
        index + 2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      return;
    }
    if (index == 9 && haveChildren != "Yes! They're my world") {
      if (!mounted) return;
      _pageController.animateToPage(
        index + 2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      return;
    }
    if (index == 11) {
      List<Map<String, dynamic>> childrenData = children.map((child) {
        return {
          "name": child["name"] is TextEditingController
              ? (child["name"] as TextEditingController).text.trim()
              : (child["name"] ?? ""),
          "birthday": child["birthday"] is TextEditingController
              ? (child["birthday"] as TextEditingController).text.trim()
              : (child["birthday"] ?? ""),
        };
      }).toList();

      await LocalStorage.saveUserData(
        name: _nameController.text.trim(),
        birthday: selectedBirthday,
        lifeExpectancy: selectedAge,
        relationship: relationship,
        goals: selectedGoals,
        haveChildren: haveChildren,
        country: countryName ?? '',
        children: childrenData,
        partnerName: _namePartner.text.trim(),
        partnerBirthday: selectedBirthdayPartner,
        anniversary: selectedAnniversaryPartner,
      );

      if (!mounted) return;
      _pageController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    if (index == 12) {
      if (!formKey.currentState!.validate()) {
        _showSnackBar("⚠️ Please enter valid email & password");
        return;
      }

      context.read<AuthBloc>().add(
        SignUpRequested(emailController.text, passwordController.text),
      );
      print("🚀 SignUpRequested sent");

      return;
    }

    if (!mounted) return;
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

    // await LocalStorage.saveUserData(
    //   name: _nameController.text.trim(),
    //   birthday: selectedBirthday,
    //   lifeExpectancy: selectedAge,
    //   relationship: relationship,
    //   goals: selectedGoals,
    //   haveChildren: haveChildren, // جديد
    // );

    setOnboardingSeen();
    Navigator.pushReplacementNamed(context, AppRouts.tabsScreen);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildButton({
    IconData? icon,
    required String text,
    required VoidCallback onPressed,
    bool isOutlined = false,
    Color? color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color != null
              ? color
              : isOutlined
              ? Colors.white
              : AppColors.pri,
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
        child: Row(
          spacing: icon != null ? 20.w : 0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(text, style: Styles.buttonText),
          ],
        ),
      ),
    );
  }
}
