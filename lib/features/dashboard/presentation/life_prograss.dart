import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/services/service_locator.dart';
import 'package:life_tracking/features/dashboard/presentation/bloc/bloc.dart';
import 'package:life_tracking/features/dashboard/presentation/bloc/event.dart';
import 'package:life_tracking/features/dashboard/presentation/bloc/state.dart';

class LifeProgressPage extends StatelessWidget {
  LifeProgressPage({super.key});

  final countries = ["Egypt", "USA"];
  final genders = ["male", "female"];
  final ageController = TextEditingController();

  String? selectedCountry;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LifeExpectancyBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Life Progress")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Country"),
                items: countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => selectedCountry = v,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Gender"),
                items: genders
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => selectedGender = v,
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Enter your age",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (selectedCountry != null &&
                      selectedGender != null &&
                      ageController.text.isNotEmpty) {
                    final age = int.parse(ageController.text);
                    context.read<LifeExpectancyBloc>().add(
                      FetchLifeExpectancy(
                        selectedCountry!,
                        selectedGender!,
                        age,
                      ),
                    );
                  }
                },
                child: const Text("Calculate"),
              ),
              const SizedBox(height: 20),
              BlocBuilder<LifeExpectancyBloc, LifeExpectancyState>(
                builder: (context, state) {
                  if (state is LifeLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is LifeLoaded) {
                    return Column(
                      children: [
                        LinearProgressIndicator(value: state.progress),
                        Text(
                          "Life Progress: ${(state.progress * 100).toStringAsFixed(1)}%",
                        ),
                      ],
                    );
                  } else if (state is LifeError) {
                    return Text(state.message);
                  }
                  return const Text("Select data and calculate");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
