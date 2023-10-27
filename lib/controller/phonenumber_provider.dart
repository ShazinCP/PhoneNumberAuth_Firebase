import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhoneProvider extends ChangeNotifier {
    PickedFile? _image;

  final TextEditingController _phoneController = TextEditingController();

  TextEditingController get phoneController => _phoneController;

    Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  void setSelectedCountry(Country country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setPhone(String value) {
    _phoneController.text = value;
    notifyListeners();
  }

   PickedFile? get image => _image;

  Future pickImage(BuildContext context) async {
    _image = await pickImage(context);
    notifyListeners();
  }
}
