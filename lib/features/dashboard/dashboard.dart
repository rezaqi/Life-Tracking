import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/dashboard/const/interstaing.dart';
import 'package:life_tracking/features/dashboard/func/get_average.dart';

class ClientInfoPage extends StatefulWidget {
  const ClientInfoPage({super.key});

  @override
  State<ClientInfoPage> createState() => _ClientInfoPageState();
}

class _ClientInfoPageState extends State<ClientInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController publicRelationsController =
      TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final Set<String> selectedInterests = {};
  String selectedCountry = "Egypt";
  String selectedGender = "other";

  @override
  void dispose() {
    publicRelationsController.dispose();
    goalsController.dispose();
    budgetController.dispose();
    notesController.dispose();
    super.dispose();
  }

  // خريطة متوسط العمر لكل دولة حسب آخر البيانات
  final Map<String, double> averageAgeByCountry = {
    "Argentina": 77.0,
    "Australia": 84.2,
    "Brazil": 76.0,
    "Canada": 82.3,
    "China": 77.0,
    "Egypt": 73.0,
    "France": 82.0,
    "Germany": 81.0,
    "Greece": 82.0,
    "India": 70.0,
    "Italy": 83.0,
    "Japan": 85.0,
    "Mexico": 77.0,
    "Netherlands": 82.0,
    "New Zealand": 82.0,
    "Norway": 82.0,
    "Poland": 78.0,
    "Portugal": 82.0,
    "Russia": 72.0,
    "Saudi Arabia": 77.0,
    "Singapore": 83.0,
    "South Africa": 64.0,
    "South Korea": 83.0,
    "Spain": 83.0,
    "Sweden": 82.0,
    "Switzerland": 83.0,
    "Thailand": 77.0,
    "Turkey": 78.0,
    "UK": 81.0,
    "USA": 79.0,
  };

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("User not logged in ❌")));
          return;
        }

        final clientData = {
          "publicRelations": publicRelationsController.text,
          "goals": goalsController.text,
          "budget": budgetController.text,
          "notes": notesController.text,
          "interests": selectedInterests.toList(),
          "createdAt": FieldValue.serverTimestamp(),
          'averageAge': getAverageAgeByGender(selectedCountry, selectedGender),
        };

        // Save data inside "userProfiles" collection using user UID
        await FirebaseFirestore.instance
            .collection("userProfiles")
            .doc(user.uid)
            .set(clientData, SetOptions(merge: true));

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouts.lifeCalendarPage,
          (r) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What are your interests?"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: publicRelationsController,
                decoration: const InputDecoration(
                  labelText: "Public Relations",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter public relations"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: goalsController,
                decoration: const InputDecoration(
                  labelText: "Primary Goals",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your goals"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: budgetController,
                decoration: const InputDecoration(
                  labelText: "Expected Budget",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Select Your Interests",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: interests.map((interest) {
                  final isSelected = selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedInterests.add(interest);
                        } else {
                          selectedInterests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Save Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
