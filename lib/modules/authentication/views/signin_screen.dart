import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novel_app/modules/authentication/controllers/authentication_controller.dart';

import '../../../widgets/snackbar.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  // final PhoneCodeController phoneCodeController =
  //     Get.put(PhoneCodeController());
  final AuthController authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final SnackBarWidget snackBar = SnackBarWidget();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    20,
                    80,
                    20,
                    20,
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo_apps.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Sign In',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    20,
                    60,
                    20,
                    40,
                  ),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      controller: emailController,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_rounded),
                        prefixIconColor: Colors.teal.shade400,
                        labelText: 'Email',
                        hintText: 'abc@provider.com',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.black),
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
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final isValidForm = formKey.currentState?.validate();
                    if (isValidForm != false) {
                      authController.signInUser(emailController.text, context);
                    } else {
                      snackBar.displaySnackBar(
                        'All field need to be fill!!',
                        Colors.red,
                        Colors.white,
                        context,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal.shade400),
                    fixedSize: MaterialStateProperty.all(const Size(100, 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Obx(
                    () => authController.isLoading.isTrue
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.teal.shade400,
                                strokeWidth: 4.0,
                                strokeCap: StrokeCap.round,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          )
                        : Text(
                            'Sign In',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.check_box,
                          color: Colors.teal.shade400,
                          size: 16,
                        ),
                      ),
                      const TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: 'By clicking you agree with\n',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'Term of Service & Privacy Policy',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/novelSignUp');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(2)),
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
