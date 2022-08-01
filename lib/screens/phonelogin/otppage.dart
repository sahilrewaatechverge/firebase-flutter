import 'package:firebase_flutter/bloc/authentication_bloc.dart';
import 'package:firebase_flutter/bloc/authentication_state.dart';
import 'package:firebase_flutter/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_event.dart';
class OtpPage extends StatefulWidget {
  final String phone;
  const OtpPage({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnAuthenticated) {
            return Scaffold(
              appBar: AppBar(title: const Text("Otp Page"),),
              body: Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  padding: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.rectangle,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Enter OTP",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: otpController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              authWithPhone(context);
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));

          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        });
  }

  void authWithPhone(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(VerifyWithPhone( smsCode: otpController.text, context: context, phone: widget.phone));
    }
  }
}
