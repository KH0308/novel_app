// ignore_for_file: use_build_context_synchronously

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        contentPadding: const EdgeInsets.all(16.0),
                        labelText: 'First Name',
                        hintText: 'Kim',
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
                        border: const OutlineInputBorder(),
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
                    const SizedBox(height: 15),
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
                        contentPadding: const EdgeInsets.all(16.0),
                        labelText: 'Last Name',
                        hintText: 'Han',
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
                        border: const OutlineInputBorder(),
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
                    const SizedBox(height: 15),
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
                        contentPadding: const EdgeInsets.all(16.0),
                        labelText: 'Email',
                        hintText: 'abc@provider.com',
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
                        border: const OutlineInputBorder(),
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
                      height: 15,
                    ),
                    Obx(
                      () => DropdownButtonFormField<String>(
                        iconEnabledColor: Colors.teal.shade400,
                        dropdownColor: Colors.grey.shade200,
                        value: phoneCodeController.selectedGender.value,
                        items: phoneCodeController.genderOpt.map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newGender) {
                          phoneCodeController.updateSelectedGender(newGender!);
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.all(16.0),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.teal.shade400,
                          ),
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
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Obx(
                            () {
                              if (phoneCodeController.isLoading.value) {
                                return Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.grey.shade200,
                                      strokeWidth: 3.0,
                                      strokeCap: StrokeCap.round,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.teal.shade400),
                                    ),
                                  ),
                                );
                              }
                              if (phoneCodeController.errorMessage.isNotEmpty) {
                                return IconButton(
                                  onPressed: () {
                                    phoneCodeController.fetchCountryCodes();
                                  },
                                  tooltip: 'No code, press to refresh',
                                  icon: const Icon(
                                    Icons.error_rounded,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                );
                              }
                              return DropdownButton<String>(
                                menuMaxHeight: 200.0,
                                iconEnabledColor: Colors.teal.shade400,
                                dropdownColor: Colors.grey.shade200,
                                value: phoneCodeController.selectedCode.value,
                                items: phoneCodeController.countryCodes
                                    .map((country) {
                                  return DropdownMenuItem<String>(
                                    value: country['code'],
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Row(
                                        children: [
                                          Text(
                                            '${country['flag']}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${country['dialCode']} (${country['code']})',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
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
                          const SizedBox(
                            width: 4,
                            height: 4,
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
                                helperText: "* Don't include country code",
                                contentPadding: const EdgeInsets.all(16.0),
                                helperStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.teal.shade400,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                hintText: '11-11111111',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.normal,
                                ),
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
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => ElevatedButton(
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

                            await authController.checkConnectivity();

                            if (authController.conStatus.isTrue &&
                                dialCode != null) {
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
                                'No Connection',
                                Colors.red,
                                Colors.white,
                                context,
                              );
                            }
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
                          fixedSize:
                              MaterialStateProperty.all(const Size(110, 40)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                'Sign Up',
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Term of Service & Privacy Policy',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed('/novelSignIn');
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
                              fontSize: 12,
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
