import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/src/common_widgets/app_text.dart';
import 'package:meditation_app/src/themes/theme.dart';
import 'home_card_widget.dart';
import 'card_one_screen.dart';
import 'caard_two_screen.dart';  // Corrected file name
import 'caard_three_screen.dart'; // Corrected file name
import 'caard_four_screen.dart';  // Corrected file name
import 'caard_five_screen.dart';  // Corrected file name
import 'caard_six_screen.dart';   // Corrected file name

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppText.normalText(
              "Good Morning",
              fontSize: 28,
              isBold: true,
              color: AppTheme.of(context).theme.headerTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppText.normalText(
              "We wish you have a good day",
              fontSize: 20,
              color: AppTheme.of(context).theme.bodyTextColor,
            ),
          ),
          const SizedBox(height: 30),
          // Container to wrap GridView and provide flexibility
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.0, // Adjusted aspect ratio
                children: [
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_one.png',
                    title: "Plank Pose (Phalakasana)",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xffebeaec),
                    buttonColor: Color(0xff3F414E),
                    destinationScreen: const CardOneScreen(), // Pass destination screen
                  ),
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_two.png',
                    title: "Warrior I (Virakkkkbhadrasana I)",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xff3F414E),
                    buttonColor: Color(0xffFEFFFE),
                    destinationScreen: const CardTwoScreen(), // Pass destination screen
                  ),
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_one.png',
                    title: "Tree Pose (Vrksasana)",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xffebeaec),
                    buttonColor: Color(0xff3F414E),
                    destinationScreen: const CardThreeScreen(), // Pass destination screen
                  ),
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_two.png',
                    title: "Child's Pose (Balasana)",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xff3F414E),
                    buttonColor: Color(0xffFEFFFE),
                    destinationScreen: const CardFourScreen(), // Pass destination screen
                  ),
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_one.png',
                    title: "Cat-Cow Pose",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xffebeaec),
                    buttonColor: Color(0xff3F414E),
                    destinationScreen: const CardFiveScreen(), // Pass destination screen
                  ),
                  HomeCardWidget(
                    backgroundImage: 'assets/images/home_cards/card_two.png',
                    title: "Bridge Pose (Setu Bandhasana)",
                    subTitle: "",
                    mainTextColor: Color(0xff3F414E),
                    textColor: Color(0xff3F414E),
                    buttonColor: Color(0xffFEFFFE),
                    destinationScreen: const CardSixScreen(), // Pass destination screen
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
