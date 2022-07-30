import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalorieda/screens/onboarding/background.dart';
import 'package:kalorieda/screens/auth/login_screen.dart';
import 'package:kalorieda/screens/auth/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Size _size;
  late double _appbarSize;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 8.0,
      width: 8.0,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white54, borderRadius: const BorderRadius.all(Radius.circular(12.0))),
    );
  }

  void _sysTemUIConfig() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void initState() {
    super.initState();
    _sysTemUIConfig(); //now we will hard reset
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _appbarSize = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Background(
        childWidget: _body(),
      ),
    );
  }

  Widget _body() {
    return SizedBox.expand(
      child: SizedBox(
        height: _size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _size.height / 2.8, //we will make the height dynamic
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/Kalorieda.png')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 250),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: const Text(
                  'Your partner in health and nutrition',
                  style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    width: 330,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 105, 181, 80)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))))),
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => const RegisterScreen()), (route) => false)
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    minWidth: 100,
                    height: 45,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(const StadiumBorder()),
                          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.white))),
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
