import 'package:flutter/material.dart';
import 'package:meditation_app/src/common_widgets/app_images.dart';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'episode_widget.dart';


class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AppImages.roundedContainerWithImage(
                  "assets/images/backgrounds/course_background.png",
                  height: 250,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 50,
                          horizontal: 20,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(

              ),
            ),
          ],
        ),
      ),
    );
  }
}
