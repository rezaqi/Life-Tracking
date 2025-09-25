import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/routs_name.dart';

import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_state.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  String? gender;
  final Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OnboardingBloc>();
    final viewModel = OnboardingViewModel(bloc: bloc);

    return Scaffold(
      appBar: AppBar(title: Text('Setup Your Profile')),
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSuccess) {
            Navigator.pushReplacementNamed(context, AppRouts.dashboardScreen);
          } else if (state is OnboardingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              DropdownButton<String>(
                value: gender,
                hint: Text('Select Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => gender = val),
              ),
              ElevatedButton(
                onPressed: () {
                  userData['age'] = _ageController.text;
                  userData['country'] = _countryController.text;
                  userData['gender'] = gender;
                  viewModel.submitData(userData);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
