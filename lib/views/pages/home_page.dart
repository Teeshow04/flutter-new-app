import 'package:flutter/material.dart';
import 'package:new_app/data/constants.dart';
import 'package:new_app/views/pages/course_page.dart';
import 'package:new_app/views/widgets/container_widget.dart';
import 'package:new_app/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.weDiscoverYourUniqueness,
      KValue.unfoldYourBold,
      KValue.designedToBeDifferent,
      KValue.everyGeniusTellsAStory,
      KValue.fromBasicToIconic,

    ];
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10.0),
                          HeroWidget(
                            nextPage: CoursePage(),
                              title: 'Showtime App'),
                          SizedBox(height: 5.0),
                          ...List.generate(
                              list.length, (index) {
                            return ContainerWidget(
                              title: list.elementAt(index),
                              description:
                              'This is a description of our goals',
                            );
                          }
                          ),
                        ],
                      ),
                    ),

              ),
      );

  }
}
