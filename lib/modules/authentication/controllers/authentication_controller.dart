// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_app/database/api_novel.dart';
import 'package:novel_app/widgets/snackbar.dart';

class AuthController extends GetxController {
  var signIn = {}.obs;
  var signUp = {}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  SnackBarWidget snackBarWidget = SnackBarWidget();

  Future<void> signUpUser(
      String email,
      String firstName,
      String lastName,
      String gender,
      String countryCode,
      String phoneNumber,
      BuildContext context) async {
    try {
      isLoading(true);
      var fetchSignUp = await ApiNovel().authSignUp(
          email, firstName, lastName, gender, countryCode, phoneNumber);
      if (fetchSignUp['user'] != null) {
        signUp.value = {
          'phoneNum': fetchSignUp['user']['phoneNumber'],
          'phoneOtp': fetchSignUp['otp'],
          'email': fetchSignUp['user']['email'],
        };

        Get.toNamed('/novelOTPValidation', arguments: signUp);
      } else if (fetchSignUp['error']['name'] == "BadRequestError") {
        snackBarWidget.displaySnackBar(
            'Account already registered', Colors.black, Colors.red, context);
      } else if (fetchSignUp['error']['name'] == "ForbiddenError") {
        snackBarWidget.displaySnackBar(
            'Access Forbidden!!', Colors.red, Colors.white, context);
      } else {
        snackBarWidget.displaySnackBar(
            "Opps there have some error, try again later",
            Colors.black,
            Colors.red,
            context);
      }
    } catch (e) {
      errorMessage.value = 'Failed to sign up: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> signInUser(String emailUser, BuildContext context) async {
    try {
      isLoading(true);
      debugPrint('${isLoading.value}');
      var fetchSignIn = await ApiNovel().authSignIn(emailUser);
      if (fetchSignIn['user'] != null) {
        snackBarWidget.displaySnackBar(
            'Welcome Back', Colors.black, Colors.white, context);
        Get.offAllNamed('/novelListHome');
      } else if (fetchSignIn['error']['name'] == "BadRequestError") {
        snackBarWidget.displaySnackBar(
            "Account doesn't exist", Colors.black, Colors.red, context);
      } else if (fetchSignIn['error']['name'] == "ForbiddenError") {
        snackBarWidget.displaySnackBar(
            "Access forbidden!!", Colors.red, Colors.white, context);
      } else {
        isLoading(false);
        snackBarWidget.displaySnackBar(
            "Opps there have some error, try again later",
            Colors.black,
            Colors.red,
            context);
      }
    } catch (e) {
      errorMessage.value = 'Failed to sign in: $e';
    } finally {
      isLoading(false);
      debugPrint('${isLoading.value}');
    }
  }

  Future<void> verifyOtp(
      String phoneNumber, String otpCode, BuildContext context) async {
    try {
      isLoading(true);
      var fetchOtp = await ApiNovel().authOTP(phoneNumber, otpCode);
      if (fetchOtp['user'] != null) {
        snackBarWidget.displaySnackBar(
            'Verify Success, Welcome', Colors.black, Colors.white, context);
        Get.offAllNamed('/novelListHome');
      } else if (fetchOtp['error']['name'] == "BadRequestError") {
        snackBarWidget.displaySnackBar(
            'Account already registered', Colors.black, Colors.red, context);
      } else if (fetchOtp['error']['name'] == "ForbiddenError") {
        snackBarWidget.displaySnackBar(
            'Access Forbidden!!', Colors.red, Colors.white, context);
      } else {
        snackBarWidget.displaySnackBar(
            "Opps there have some error, try again later",
            Colors.black,
            Colors.red,
            context);
      }
    } catch (e) {
      errorMessage.value = 'Failed to verify OTP: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> resendOtp(String emailUser, BuildContext context) async {
    try {
      isLoading(true);
      var reFetchOtp = await ApiNovel().reAuthOtp(emailUser);
      if (reFetchOtp.length == 6) {
        snackBarWidget.displaySnackBar(
            'OTP resend is $reFetchOtp', Colors.black, Colors.white, context);
      } else if (reFetchOtp['error']['name'] == "BadRequestError") {
        snackBarWidget.displaySnackBar(
            "OTP resend failed", Colors.black, Colors.red, context);
      } else if (reFetchOtp['error']['name'] == "ForbiddenError") {
        snackBarWidget.displaySnackBar(
            "Access forbidden!!", Colors.red, Colors.white, context);
      } else {
        snackBarWidget.displaySnackBar(
            "Opps there have some error, try again later",
            Colors.black,
            Colors.red,
            context);
      }
    } catch (e) {
      errorMessage.value = 'Failed to resend OTP: $e';
    } finally {
      isLoading(false);
    }
  }
}
