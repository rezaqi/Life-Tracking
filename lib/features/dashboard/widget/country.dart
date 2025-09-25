import 'package:flutter/material.dart';
import 'package:life_tracking/features/dashboard/const/average_country.dart';
import 'package:life_tracking/features/dashboard/func/get_average.dart';

class ChoseCountry extends StatefulWidget {
  const ChoseCountry({super.key});

  @override
  State<ChoseCountry> createState() => _ChoseCountryState();
}

class _ChoseCountryState extends State<ChoseCountry> {
  @override
  Widget build(BuildContext context) {
    String selectedCountry = "Egypt";
    String selectedGender = "other";

    return Row(
      children: [
        DropdownButtonFormField<String>(
          value: selectedCountry,
          decoration: const InputDecoration(
            labelText: "Select Country",
            border: OutlineInputBorder(),
          ),
          items: averageAgeByCountryAndGender.keys.map((country) {
            return DropdownMenuItem(value: country, child: Text(country));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCountry = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: const InputDecoration(
            labelText: "Select Gender",
            border: OutlineInputBorder(),
          ),
          items: ["male", "female", "other"].map((gender) {
            return DropdownMenuItem(value: gender, child: Text(gender));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        Text(
          "متوسط العمر: ${getAverageAgeByGender(selectedCountry, selectedGender)} سنة",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
