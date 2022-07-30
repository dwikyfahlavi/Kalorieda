import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalorieda/models/provider/authentication_provider.dart';
import 'package:kalorieda/models/provider/profile_provider.dart';
import 'package:kalorieda/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

import '../../components/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void getUserData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('user').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      setState(() {
        _nameController.text = value.data()?['name'];
        _emailController.text = value.data()?['email'];
        _phoneController.text = value.data()?['phone'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference users = firestore.collection('user').doc(FirebaseAuth.instance.currentUser?.uid);

    return Scaffold(
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: users.snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    print('loading');
                    return const CircularProgressIndicator();
                  } else {
                    return Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/bg_profile.png'),
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: Text(
                              'Profile Screen',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 25),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(8),
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/example_avatar.png'),
                                ),
                              ),
                              Container(
                                height: 150,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      snapshot.data?['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.solidEnvelope,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          snapshot.data?['email'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const FaIcon(FontAwesomeIcons.phone, size: 15, color: Colors.white),
                                        const SizedBox(width: 10),
                                        Text(
                                          snapshot.data?['phone'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.custom,
                        barrierDismissible: true,
                        confirmBtnText: 'Save',
                        widget: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    suffixIcon: IconButton(
                                      onPressed: _nameController.clear,
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Your Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                      return 'Phone Number min. 9 character';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        onConfirmBtnTap: () async {
                          if (!_formKey.currentState!.validate()) return;
                          Navigator.pop(context);

                          String cek = await provider.updateUser(
                              _nameController.text, _emailController.text, _phoneController.text);
                          if (cek == 'Success') {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Your data has been updated!.",
                            );
                          } else {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Your data is failed update!.",
                            );
                          }
                        },
                      );
                    },
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: createMaterialColor(const Color.fromARGB(43, 39, 165, 47)),
                        ),
                        child: const FaIcon(FontAwesomeIcons.addressCard),
                      ),
                      title: const Text('Edit Profile'),
                      trailing: const FaIcon(FontAwesomeIcons.angleRight),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: createMaterialColor(const Color.fromARGB(43, 39, 165, 47)),
                      ),
                      child: const FaIcon(FontAwesomeIcons.gear),
                    ),
                    title: const Text('Setting'),
                    trailing: const FaIcon(FontAwesomeIcons.angleRight),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await context.read<AuthenticationProvider>().signOut();
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                    },
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: createMaterialColor(const Color.fromARGB(48, 70, 70, 70)),
                        ),
                        child: const FaIcon(FontAwesomeIcons.rightFromBracket),
                      ),
                      title: const Text('Sign Out'),
                      trailing: const FaIcon(FontAwesomeIcons.angleRight),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
