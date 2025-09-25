import 'package:flutter/material.dart';

class FollowEvents extends StatelessWidget {
  const FollowEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              children: [Text("Precious moments"), Text("Important events")],
            ),
          ),
        ],
      ),
    );
  }
}
