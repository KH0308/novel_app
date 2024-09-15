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
    // final phoneNum = signUpData['phoneNum'];
    var otpCode = signUpData['phoneOtp'];
    final emailUsAsResendOtp = signUpData['email'];
    final AuthController authController = AuthController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (otpCode != null) {
        otpController.text = otpCode;
      }
    });

    authController.currentOtp.listen((otp) {
      if (otpController.text.isEmpty) {
        otpController.text = otp;
      }
    });

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const RangeMaintainingScrollPhysics(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.95,
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
                        'Enter OTP sent to $emailUsAsResendOtp',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
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
                        decoration: InputDecoration(
                          labelText: 'OTP Code',
                          hintText: '******',
                          border: const OutlineInputBorder(),
                          floatingLabelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                          ),
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade400),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorStyle: const TextStyle(color: Colors.red),
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
                          Obx(
                            () => TextButton(
                              onPressed: () {
                                otpCode = '';
                                otpController.clear();
                                authController.resendOtp(
                                  emailUsAsResendOtp,
                                  context,
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.all(2)),
                              ),
                              child: authController.isResendOTP.isTrue
                                  ? Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.teal.shade400,
                                          strokeWidth: 4.0,
                                          strokeCap: StrokeCap.round,
                                          valueColor:
                                              const AlwaysStoppedAnimation(
                                                  Colors.white),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Resend',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          // TextButton(
                          //     onPressed: () {
                          //       snackBarWidget.displaySnackBar(
                          //         '$otpCode',
                          //         Colors.red,
                          //         Colors.white,
                          //         context,
                          //       );
                          //     },
                          //     child: Text('test'))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authController.verifyOtp(emailUsAsResendOtp,
                                  otpController.text, context);
                            } else {
                              snackBarWidget.displaySnackBar(
                                'Please enter a valid OTP',
                                Colors.red,
                                Colors.white,
                                context,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.teal.shade400),
                            fixedSize:
                                MaterialStateProperty.all(const Size(130, 50)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: authController.isLoading.isTrue
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.teal.shade400,
                                      strokeWidth: 4.0,
                                      strokeCap: StrokeCap.round,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Verify OTP',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
