import 'package:flutter/material.dart';
import 'package:kalorieda/components/theme.dart';
import 'package:kalorieda/models/provider/authentication_provider.dart';
import 'package:kalorieda/models/provider/detail_food_provider.dart';
import 'package:kalorieda/models/provider/food_provider.dart';
import 'package:kalorieda/models/provider/home_provider.dart';
import 'package:kalorieda/models/provider/profile_provider.dart';
import 'package:kalorieda/screens/dashboard/main_screen.dart';
import 'package:kalorieda/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _initiazlizeFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FoodProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailFoodProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Contacts App',
          theme: ThemeData(primarySwatch: createMaterialColor(const Color(0xff27A52F)), fontFamily: 'Poppins'),
          home: Scaffold(
            body: FutureBuilder(
              future: _initiazlizeFireBase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FirebaseAuth.instance.currentUser == null ? WelcomeScreen() : const MainScreen();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
