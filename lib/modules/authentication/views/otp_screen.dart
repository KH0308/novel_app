import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/snackbar.dart';
import '../controllers/authentication_controller.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});
  final SnackBarWidget snackBarWidget = SnackBarWidget();
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> signUpData = Get.arguments;
    final phoneNum = signUpData['phoneNum'];
    final otpCode = signUpData['phoneOtp'];
    final emailUsAsResendOtp = signUpData['email'];
    final AuthController authController = AuthController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      snackBarWidget.displaySnackBar(
        'OTP has been sent to $phoneNum',
        Colors.black,
        Colors.white,
        context,
      );
    });

    otpController.text = otpCode ?? '';

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const RangeMaintainingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'OTP Verification',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Enter OTP sent to $phoneNum',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'OTP is required';
                        } else if (value.length != 6) {
                          return 'OTP must be exactly 6 digits';
                        }
                        return null;
                      },
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: 'OTP Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't received OTP code ?",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            authController.resendOtp(
                                emailUsAsResendOtp, context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.all(2)),
                          ),
                          child: Text(
                            'Resend',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authController.verifyOtp(
                              phoneNum, otpController.text, context);
                        } else {
                          snackBarWidget.displaySnackBar(
                            'Please enter a valid OTP',
                            Colors.red,
                            Colors.white,
                            context,
                          );
                        }
                      },
                      child: const Text('Verify OTP'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
