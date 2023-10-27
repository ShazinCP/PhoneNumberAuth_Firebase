import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/phonenumber_provider.dart';
import 'package:phonenumberauth/utils/utils.dart';
import 'package:phonenumberauth/view/home/home_screen.dart';
import 'package:phonenumberauth/view/user_information/user_information_screen.dart';
import 'package:phonenumberauth/widget/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : Consumer<PhoneProvider>(
                builder: (context, value, child) {
                 return SingleChildScrollView(
                   child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 30),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.arrow_back),
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple.shade50,
                              ),
                              child: Image.asset(
                                "assets/image2.png",
                              ),
                            ),
                            cHeight20,
                            const Text(
                              "Verification",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            cHeight10,
                            const Text(
                              "Enter the OTP send to your phone number",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            cHeight20,
                            Pinput(
                              length: 6,
                              showCursor: true,
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.purple.shade200,
                                  ),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onCompleted: (value) {
                                setState(() {
                                  otpCode = value;
                                });
                              },
                            ),
                            cHeight25,
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: CustomButton(
                                text: "Verify",
                                onpressed: () {
                                  if (otpCode != null) {
                                    verifyOtp(context, otpCode!);
                                  } else {
                                    showSnackBar(context, "Enter 6-Digit code");
                                  }
                                },
                              ),
                            ),
                            cHeight20,
                            const Text(
                              "Didn't receive any code?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            ),
                            cHeight15,
                            const Text(
                              "Resend New Code",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                 );
                },
              ),
      ),
    );
  }

  // VERIFY OTP
  void verifyOtp(BuildContext context, String userOtp) {
    final data = Provider.of<AuthProvider>(context, listen: false);
    data.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // CHECKING WHETHER USER EXISTS IN THE DB
        data.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // USER EXISTS IN OUR APP
              data.getDataFromFirestore().then(
                    (value) => data.saveUserDataToSP().then(
                          (value) => data.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // NEW USER
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
