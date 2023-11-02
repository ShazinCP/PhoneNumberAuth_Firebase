import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonenumberauth/model/user_model.dart';
import 'package:phonenumberauth/services/firebase_services.dart';

class PhoneProvider extends ChangeNotifier {
    PickedFile? _image;

  final TextEditingController _phoneController = TextEditingController();

  TextEditingController get phoneController => _phoneController;

  List<UserModel> users = [];

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();


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


    ////////////Crud Functions//////////////

  final FirebaseServices firebaseServices = FirebaseServices();


  Future<void> fetchTasks() async {
    users = await firebaseServices.fetchUser();
    notifyListeners();
  }

  Future<void> deleteUser(String docId) async {
    firebaseServices.deleteUser(docId);
    await fetchTasks();
    notifyListeners();
  }

  void updateTask(String docId) async {

    final user = UserModel(
      name: nameController.text, 
      email: emailController.text, 
      bio: bioController.text, 
      profilePic: "", 
      createdAt: docId,
       phoneNumber: phoneController.text, 
       uid: phoneController.text,
       );
    firebaseServices.updateUser(user);
    await fetchTasks();
    notifyListeners();
  }

    // UserModel userModel = UserModel(
    //   name: nameController.text.trim(),
    //   email: emailController.text.trim(),
    //   bio: bioController.text.trim(),
    //   profilePic: "",
    //   createdAt: "",
    //   phoneNumber: "",
    //   uid: "",
    // );
}
