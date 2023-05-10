
import 'package:cinema_bloc_ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';


import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_event.dart';
import '../bloc/auth_bloc/auth_state.dart';
import '../widgets/login_widgets/my_button.dart';


class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String text = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is OtpLoadingState) {
            return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is OtpErrorState) {
        return const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        );
      }
      if (state is OtpLoadedState) {
        return Stack(

          children: [
            Image.asset(
              'Assets/images/pepe-cold.gif',
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              fit: BoxFit.cover,
            ),
            //BackgroundImage(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child:

                // isLoading == true
                //     ? const Center(
                //   child: CircularProgressIndicator(
                //     color: Colors.blue,
                //   ),
                // )
                //     :
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 150,
                        //   height: 150,
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Image.asset(
                        //     "assets/logo.png",
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        const Text(
                          "Verification",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Pinput(
                          length: 4,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade100,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              text = value;
                            });
                          },
                        ),
                        const SizedBox(height: 250),
                        MyButton(
                          onTap: () {
                            if (text.isNotEmpty ) {
                              BlocProvider.of<AuthBloc>(context).add(
                                ProceedAuthEvent(
                                  widget.phoneNumber,
                                  text
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomeCinePage();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Please enter otp',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
          return Container();
    });


  }
}
