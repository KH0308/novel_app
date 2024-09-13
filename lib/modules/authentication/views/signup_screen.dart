import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/snackbar.dart';
import '../controllers/authentication_controller.dart';
import '../controllers/phone_code_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final PhoneCodeController phoneCodeController =
      Get.put(PhoneCodeController());
  final AuthController authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final SnackBarWidget snackBar = SnackBarWidget();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  // String genderDefValue = 'Male';

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: fNameController,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.abc_rounded),
                        prefixIconColor: Colors.teal.shade400,
                        labelText: 'First Name',
                        hintText: 'Kim',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                        ),
                        fillColor: Colors.orange.shade100,
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
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: lNameController,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.abc_rounded),
                        prefixIconColor: Colors.teal.shade400,
                        labelText: 'Last Name',
                        hintText: 'Han',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                        ),
                        fillColor: Colors.orange.shade100,
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
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                        fillColor: Colors.orange.shade100,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        value: phoneCodeController.selectedGender.value,
                        items: phoneCodeController.genderOpt.map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (newGender) {
                          phoneCodeController.updateSelectedGender(newGender!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          filled: true,
                          fillColor: Colors.orange.shade100,
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                            () {
                              if (phoneCodeController.isLoading.value) {
                                return Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.teal.shade400,
                                      strokeWidth: 6.0,
                                      strokeCap: StrokeCap.round,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.black),
                                    ),
                                  ),
                                );
                              }
                              if (phoneCodeController.errorMessage.isNotEmpty) {
                                return const Icon(
                                  Icons.error_rounded,
                                  size: 12,
                                  color: Colors.red,
                                );
                              }
                              return DropdownButton<String>(
                                value: phoneCodeController.selectedCode.value,
                                items: phoneCodeController.countryCodes
                                    .map((country) {
                                  return DropdownMenuItem<String>(
                                    value: country['code'],
                                    child: Row(
                                      children: [
                                        Text('${country['flag']}'),
                                        const SizedBox(width: 8),
                                        Text(
                                            '${country['dialCode']} (${country['name']})'),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newCode) {
                                  phoneCodeController
                                      .updateSelectedCode(newCode!);
                                },
                              );
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                return null;
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              controller: phoneNumController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                helperText:
                                    'No need start phone number with country code*',
                                helperStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.teal.shade400,
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: '11-11111111',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.normal,
                                ),
                                border: const OutlineInputBorder(),
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade400),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade400),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                errorStyle: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final isValidForm = formKey.currentState?.validate();
                        if (isValidForm != false) {
                          final selectedCountry =
                              phoneCodeController.countryCodes.firstWhere(
                            (country) =>
                                country['code'] ==
                                phoneCodeController.selectedCode.value,
                            orElse: () => {'dialCode': ''},
                          );
                          final dialCode = selectedCountry['dialCode'];

                          final fullPhoneNumber =
                              '$dialCode${phoneNumController.text}';

                          authController.signUpUser(
                            emailController.text,
                            fNameController.text,
                            lNameController.text,
                            phoneCodeController.selectedGender.value,
                            phoneCodeController.selectedCode.value,
                            fullPhoneNumber,
                            context,
                          );
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text('Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          )),
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
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.all(2)),
                          ),
                          child: Text(
                            'Sign In',
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
        ),
      ),
    );
  }
}
