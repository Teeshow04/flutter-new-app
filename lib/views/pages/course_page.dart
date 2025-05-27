

import 'package:flutter/material.dart';
import 'package:quoteflow_app/views/widgets/hero_widget.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroWidget(
                      title: 'Course')
                  ]
              ),
            ),
          )
      );
  }
}
