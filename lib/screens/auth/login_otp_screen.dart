import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalorieda/models/provider/authentication_provider.dart';
import 'package:kalorieda/models/user_model.dart';
import 'package:kalorieda/screens/dashboard/main_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +62-${widget.phone}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              onCompleted: (pin) async {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: context.read<AuthenticationProvider>().verificationCode, smsCode: pin))
                    .then((value) async {
                  await context.read<AuthenticationProvider>().registerToFireStore(
                      context.read<AuthenticationProvider>().getCurrentUser(),
                      MyUser(email: 'default@gmail.com', name: 'default name', phone: widget.phone));
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false);
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Success'),
                    ),
                  );
                });
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<AuthenticationProvider>().loginUsingPhone(widget.phone);
    });
  }
}
