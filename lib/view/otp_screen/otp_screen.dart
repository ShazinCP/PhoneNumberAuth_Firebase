import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/helper/colors.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(children: [
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cPurpleColorShade,
                ),
                child: Image.asset("assets/image2.png"),
              ),
              cHeight20,
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cHeight10,
              const Text(
                "Add your phone number. we'll send a verification code",
                style: TextStyle(
                  fontSize: 14,
                  color: cBlackColor38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              cHeight20,
            ]),
          ),
        ),
      ),
    );
  }
}
