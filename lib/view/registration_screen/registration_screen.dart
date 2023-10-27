import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/phonenumber_provider.dart';
import 'package:phonenumberauth/widget/custom_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PhoneProvider>(context);
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
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
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  cHeight10,
                  const Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                 cHeight20,
                  TextFormField(
                    cursorColor: Colors.purple,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      // setState(() {
                      //   phoneController.text = value;
                      // });
                      data.setPhone(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  // setState(() {
                                  //   selectedCountry = value;
                                  // });
                                  data.setSelectedCountry(value);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              "${data.selectedCountry.flagEmoji} + ${data.selectedCountry.phoneCode}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                  ),
                  cHeight20,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: "Login",
                      onpressed: () => sendPhoneNumber(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber(BuildContext context) {
    final value = Provider.of<AuthProvider>(context, listen: false);
    final data = Provider.of<PhoneProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    value.signInWithPhone(
        context, "+${data.selectedCountry.phoneCode}$phoneNumber");
  }
}
