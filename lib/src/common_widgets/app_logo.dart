import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/icons/app_icon.svg",
      semanticsLabel: 'A red up arrow',
      fit: BoxFit.cover,
    );
  }
}


