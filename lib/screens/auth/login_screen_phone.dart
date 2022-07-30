import 'package:flutter/material.dart';
import 'package:kalorieda/components/RoundedButton.dart';
import 'package:kalorieda/screens/auth/login_otp_screen.dart';

import '/Animation/FadeAnimation.dart';

class LoginScreenPhone extends StatefulWidget {
  const LoginScreenPhone({Key? key}) : super(key: key);

  @override
  State<LoginScreenPhone> createState() => _LoginScreenPhoneState();
}

class _LoginScreenPhoneState extends State<LoginScreenPhone> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  late bool isLogin;
  bool isAccount = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 233, 240),
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
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                prefix: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('+62'),
                                ),
                                border: InputBorder.none,
                                hintText: "Enter phone number",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                suffixIcon: IconButton(
                                  onPressed: _phoneController.clear,
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Phone Number';
                                } else if (value.length < 10) {
                                  return 'Password min. 9 character';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        2,
                        RoundedButtonWidget(
                          buttonText: 'Login',
                          onpressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => OTPScreen(_phoneController.text)));
                          },
                          width: double.infinity,
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
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            iconSize: 25.0,
                          ),
                        ),
                      ), // Ink
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
