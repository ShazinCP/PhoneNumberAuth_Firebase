import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/internet_connectivity_provider.dart';
import 'package:phonenumberauth/helper/colors.dart';
import 'package:phonenumberauth/view/intro/welcome_screen.dart';
import 'package:phonenumberauth/widget/uppercase.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<InternetConnectivityProvider>(context, listen: false)
        .getInternetConnectivity(context);
    final data = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPurpleColor,
        title: const Text("PhoneNumber Auth",style: TextStyle(color: cWhiteColor),),
        actions: [
          IconButton(
            onPressed: () {
              data.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          cHeight10,
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                 Navigator.pushNamed(context, '/EditScreen',
                                  arguments: {
                                    'name': data.userModel.name,
                                    'email': data.userModel.email,
                                    'bio': data.userModel.bio,
                                    'phoneNumber': data.userModel.phoneNumber,
                                    'createdAt': data.userModel.createdAt,
                                    'uid': data.userModel.uid
                                  });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: cBlueColor,
                      size: 30,
                    )),
                cWidth10
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: cPurpleColor,
            backgroundImage: NetworkImage(data.userModel.profilePic),
            radius: 50,
          ),
          cHeight20,
          Text(
            data.userModel.name.capitalize(),
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          Text(data.userModel.phoneNumber),
          Text(data.userModel.email),
          Text(data.userModel.bio.capitalize()),
        ],
      )),
    );
  }
}
