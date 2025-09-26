import 'package:flutter/material.dart';

class CreateAccountFooter extends StatelessWidget {
  const CreateAccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // OR divider
        Row(
          children: const [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("OR"),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const SizedBox(height: 20),

        // Google button
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.g_mobiledata),
          label: const Text("Continue with Google"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Apple button
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.apple),
          label: const Text("Continue with Apple"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Create account button
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Text("✓ Create Account"),
        //   style: ElevatedButton.styleFrom(
        //     padding: const EdgeInsets.symmetric(vertical: 16),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        // ),
        //  const SizedBox(height: 20),

        // Already have account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(onPressed: () {}, child: const Text("Sign In Here")),
          ],
        ),
      ],
    );
  }
}
