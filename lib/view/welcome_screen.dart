import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/internet_connectivity_provider.dart';
import 'package:phonenumberauth/helper/colors.dart';
import 'package:phonenumberauth/view/home_screen.dart';
import 'package:phonenumberauth/view/registration_screen.dart';
import 'package:phonenumberauth/widget/custom_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetConnectivityProvider>(context, listen: false)
        .getInternetConnectivity(context);
    final data = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image1.png",
                  height: 300,
                ),
                cHeight20,
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                cHeight10,
                const Text(
                  "Never a better time than now to start. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: cBlackColor38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                cHeight20,
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Get Started",
                    onpressed: () async {
                      if (data.isSignedIn == true) {
                        await data.getDataFromSP().whenComplete(
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const HomeScreen(),
                                ),
                              ),
                            );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
