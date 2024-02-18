import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:todolist/Custom Widgets/utility_manager.dart';

import '../../Custom Widgets/m_n_custom_icons_icons.dart';
import '../../Custom Widgets/social_sign_in_button.dart';
import '../Home/homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.modeAction}) : super(key: key);

  final Widget modeAction;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _basicStates = Hive.box('stateBox');
  final TextEditingController _otpController = TextEditingController();
  final firebase = FirebaseAuth.instance;
  // final TextEditingController _controller2 = TextEditingController();

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );

    return firebase.signInWithCredential(credential);
  }

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
            const SizedBox(height: 10),
            // Sign In with Google
            SocialSignInButton(
              icon: Icons.person,
              iconColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              text: 'No Sign in',
              textColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : Colors.teal,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            // Sign In with Google
            SocialSignInButton(
              icon: MNCustomIcons.icons8_google_48,
              iconColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              text: 'Sign in with Google',
              textColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : Colors.grey.shade800,
              onTap: () {
                signInWithGoogle();
              },
            ),
            const SizedBox(height: 10),

            // Sign in With Facebook
            SocialSignInButton(
              icon: Icons.facebook,
              text: 'Sign in with Facebook',
              textColor: _basicStates.get('darkLightMode') == 0
                  ? Colors.grey.shade800
                  : Colors.white,
              iconColor: _basicStates.get('darkLightMode') == 0
                  ? const Color.fromRGBO(23, 112, 229, 1.0)
                  : Colors.white,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : const Color.fromRGBO(23, 112, 229, 1.0),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            SocialSignInButton(
              icon: Icons.login,
              text: 'Sign in anonymously',
              textColor: Colors.white,
              iconColor: Colors.white,
              color: utilManager.colorSelector(),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ),
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
