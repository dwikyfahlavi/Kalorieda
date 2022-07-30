import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalorieda/components/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kalorieda/screens/auth/login_screen_phone.dart';
import 'package:kalorieda/screens/auth/register_screen.dart';
import 'package:kalorieda/screens/dashboard/main_screen.dart';
import 'package:provider/provider.dart';

import '/Animation/FadeAnimation.dart';
import '/models/provider/authentication_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _sysTemUIConfig() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    _sysTemUIConfig(); //now we will hard reset
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 233, 240),
      // backgroundColor: Color.fromARGB(255, 231, 224, 224),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 100,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 100,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter email",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    suffixIcon: IconButton(
                                      onPressed: _emailController.clear,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Your Email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    suffixIcon: IconButton(
                                      onPressed: _passwordController.clear,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Your Password';
                                    } else if (value.length < 5) {
                                      return 'Password min. 5 character';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.5,
                        Container(
                          alignment: FractionalOffset.center,
                          child: Row(
                            children: <Widget>[
                              const Text('Don\'t have an account?', style: TextStyle(color: Color(0xFF2E3233))),
                              TextButton(
                                child: const Text(
                                  'Register',
                                  style:
                                      TextStyle(color: Color.fromARGB(255, 236, 46, 46), fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                      (route) => false);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        2,
                        Consumer<AuthenticationProvider>(
                          builder: (context, value, child) {
                            final isLoading = value.state == UserAuthProviderState.loading;
                            final isError = value.state == UserAuthProviderState.error;

                            if (isLoading) {
                              return const CircularProgressIndicator();
                            }
                            if (isError) {
                              Future.delayed(
                                Duration.zero,
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Wrong username or password!')),
                                  );
                                  value.changeState(UserAuthProviderState.none);
                                },
                              );
                            }

                            return RoundedButtonWidget(
                              buttonText: 'Login',
                              onpressed: () async {
                                if (!_formKey.currentState!.validate()) return;

                                User? user = await value.loginUsingEmailPassword(
                                    email: _emailController.text, password: _passwordController.text, context: context);

                                if (user != null) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false);
                                }
                              },
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const FadeAnimation(
                        1.5,
                        Text(
                          "Or continue with",
                          style: TextStyle(
                              color: Color.fromARGB(255, 90, 90, 90), fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        2,
                        Container(
                          decoration: const ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Color.fromARGB(255, 143, 251, 143),
                                Color.fromARGB(195, 116, 211, 121),
                              ],
                            ),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => const LoginScreenPhone()));
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            iconSize: 25.0,
                          ),
                        ), // Ink
                      ),
                    ],
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
