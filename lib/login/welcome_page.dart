// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_event.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../widgets/login_widgets/my_button.dart';
import '../widgets/login_widgets/my_textfield.dart';
import 'otp_page.dart';


class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // text editing controllers
  final phoneController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'Assets/images/pepe_cinema.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              const Text("Pepe MovieTheatre ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 71, 233, 133),
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.60),

                    //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    //SizedBox(height: 200,),
                    ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // username textfield
                                  MyTextField(
                                    phoneController: phoneController,
                                    hintText: '+3806612345678',
                                    obscureText: false,

                                  ),

                                  const SizedBox(height: 30),

                                  MyButton(
                                    onTap: (() {
                                      if (phoneController.text.isNotEmpty && _formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          RequestOtpAuthEvent(phoneController.text),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OtpScreen(phoneNumber: phoneController.text,)),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Please enter a phone number',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  });
  }}


