import 'package:flutter/material.dart';
import 'package:phonenumberauth/constants/sizedbox.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/internet_connectivity_provider.dart';
import 'package:phonenumberauth/view/intro/welcome_screen.dart';
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
        backgroundColor: Colors.purple,
        title: const Text("PhoneNumber Auth"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
            backgroundImage: NetworkImage(data.userModel.profilePic),
            radius: 50,
          ),
          cHeight20,
          Text(data.userModel.name),
          Text(data.userModel.phoneNumber),
          Text(data.userModel.email),
          Text(data.userModel.bio),
        ],
      )),
    );
  }
}
