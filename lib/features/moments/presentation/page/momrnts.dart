import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/features/moments/presentation/widget/add_memory_modal.dart';
import 'package:life_tracking/features/moments/presentation/widget/fancyAnimatedRing.dart';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moments"),
        //  actions: [IconButton(onPressed: onPressed, icon: icon)]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                ),
                itemCount: 7,
                itemBuilder: (context, index) =>
                    FancyAnimatedRing(progressTarget: 0.86),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddMemoryModal());
        },
        child: Icon(Icons.add),
        tooltip: 'Add Memory',
      ),
    );
  }
}
