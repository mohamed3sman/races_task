import 'package:flutter/material.dart';
import 'package:tesk/features/races_view/view/widgets/races_body.dart';

class RacesViewBody extends StatelessWidget {
  const RacesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      Center(child: Text('One')),
      Center(child: Text('Two')),
      RacesBody(),
    ]);
  }
}
