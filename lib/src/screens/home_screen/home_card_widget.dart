import 'package:flutter/material.dart';
import 'package:meditation_app/src/common_widgets/app_buttons.dart';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'package:meditation_app/src/screens/course_details_screen/course_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HomeCardWidget(
                backgroundImage: 'assets/images/background1.jpg',
                title: 'Yoga Pose 1',
                subTitle: 'Short description 1',
                mainTextColor: Colors.white,
                textColor: Colors.white70,
                buttonColor: Colors.blue,
                destinationScreen: const CourseDetailsScreen(), // Replace with actual screen
              ),
              const SizedBox(height: 20), // Add space between cards
              HomeCardWidget(
                backgroundImage: 'assets/images/background2.jpg',
                title: 'Yoga Pose 2',
                subTitle: 'Short description 2',
                mainTextColor: Colors.white,
                textColor: Colors.white70,
                buttonColor: Colors.green,
                destinationScreen: const CourseDetailsScreen(), // Replace with actual screen
              ),
              // Add more HomeCardWidgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCardWidget extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String subTitle;
  final Color mainTextColor;
  final Color textColor;
  final Color buttonColor;
  final Widget destinationScreen;

  const HomeCardWidget({
    Key? key,
    required this.backgroundImage,
    required this.title,
    required this.subTitle,
    required this.mainTextColor,
    required this.textColor,
    required this.buttonColor,
    required this.destinationScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(context),
      child: Container(
        width: double.infinity, // Use full width
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.normalText(
                  title,
                  fontSize: 14,
                  isBold: true,
                  color: mainTextColor,
                ),
                AppText.normalText(
                  subTitle,
                  fontSize: 11,
                  color: mainTextColor,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                AppText.normalText(
                  "3-10 MIN",
                  fontSize: 11,
                  color: textColor,
                ),
                const Spacer(),
                AppButtons.mainButton(
                  "Start",
                  textColor: buttonColor,
                  buttonColor: textColor,
                  onPressed: () => onClicked(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => destinationScreen,
      ),
    );
  }
}
