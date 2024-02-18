import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';

import '../Home/homepage.dart';

class OTPValidation extends StatefulWidget {
  const OTPValidation({super.key});

  @override
  State<OTPValidation> createState() => _OTPValidationState();
}

class _OTPValidationState extends State<OTPValidation> {
  final _basicStates = Hive.box('stateBox');
  final TextEditingController _otpController = TextEditingController();
  final firebase = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        controller: _otpController,
        onChanged: (value) {},
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () async {
              await firebase.verifyPhoneNumber(
                phoneNumber: _otpController.text,
                verificationCompleted: (completed) {
                  EasyLoading.showSuccess("Verification Completed");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage()));
                  setState(() {});
                },
                verificationFailed: (error) {
                  EasyLoading.showError("${error.message}");
                  setState(() {});
                },
                codeSent: (send, otp) {
                  EasyLoading.showSuccess("Code Sent");
                  setState(() {});
                },
                codeAutoRetrievalTimeout: (timeout) {
                  EasyLoading.showError("Timeout!!!");
                  setState(() {});
                },
              );
            },
            icon: const Icon(
              Icons.send,
              color: Colors.greenAccent,
            ),
          ),
          fillColor: _basicStates.get('darkLightMode') == 0
              ? Colors.white
              : Colors.grey.shade800,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 15,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: Colors.greenAccent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: _basicStates.get('darkLightMode') == 0
                  ? Colors.white
                  : Colors.grey.shade800,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: "Sign in with OTP",
          labelStyle: TextStyle(
            color: _basicStates.get('darkLightMode') == 0
                ? Colors.white
                : Colors.black,
          ),
          hintText: "+8801234567890",
          hintStyle: TextStyle(
            color: _basicStates.get('darkLightMode') == 0
                ? Colors.white
                : Colors.grey.shade800,
          ),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
