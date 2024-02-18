import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/util/custom_text_field.dart';
import 'package:todolist/util/utility_manager.dart';

import '../util/custom_button.dart';
import '../util/social_sign_in_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.modeAction}) : super(key: key);

  final Widget modeAction;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _basicStates = Hive.box('stateBox');
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    UtilManager utilManager = UtilManager(
      selectedDate: DateTime.now(),
      screenHeight: screenSize.height,
      screenWidth: screenSize.width,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo Sign up"),
        centerTitle: true,
        actions: [
          const SizedBox(width: 10),
          widget.modeAction,
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 48.0),

            // Sign In with Google
            SocialSignInButton(
              assetPath: 'images/google-logo.png',
              text: 'Sign in with Google',
              textColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : Colors.grey.shade800,
              onPressed: () {},
            ),
            const SizedBox(height: 10),

            // Sign in With Facebook
            SocialSignInButton(
              assetPath: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              iconColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : const Color.fromRGBO(23, 112, 229, 1.0),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SocialSignInButton(
              assetPath: 'images/sign_in.png',
              text: 'Sign in anonymously',
              textColor: Colors.white,
              iconColor: Colors.white,
              color: utilManager.colorSelector(),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
