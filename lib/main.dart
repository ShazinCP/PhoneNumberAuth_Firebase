import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonenumberauth/controller/auth_provider.dart';
import 'package:phonenumberauth/controller/internet_connectivity_provider.dart';
import 'package:phonenumberauth/controller/phonenumber_provider.dart';
import 'package:phonenumberauth/view/edit_screen.dart';
import 'package:phonenumberauth/view/home_screen.dart';
import 'package:phonenumberauth/view/welcome_screen.dart';
import 'package:phonenumberauth/view/user_information_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => PhoneProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => InternetConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
         routes: {
            '/HomeScreen': (context) =>  const HomeScreen(),
            "/UserInformationScreen": (context) => const UserInformationScreen(),
            '/EditScreen': (context) => const EditScreen()
          },
        debugShowCheckedModeBanner: false,
        title: 'PhoneNumberAuth',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
