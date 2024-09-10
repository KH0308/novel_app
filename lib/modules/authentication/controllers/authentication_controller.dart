import 'package:get/get.dart';
import 'package:novel_app/database/api_novel.dart';

class AuthController extends GetxController {
  var signIn = {}.obs;
  var signUp = {}.obs;
  var codeOTP = {}.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> signUpUser(String email, String firstName, String lastName,
      String gender, String countryCode, String phoneNumber) async {
    try {
      isLoading(true);
      var fetchSignUp = await ApiNovel().authSignUp(
          email, firstName, lastName, gender, countryCode, phoneNumber);
      signUp.value = {
        'phoneNum': fetchSignUp['user']['phoneNumber'],
        'phoneOtp': fetchSignUp['otp'],
      };
      Get.toNamed('/novelOTPValidation', arguments: signUp);
    } catch (e) {
      errorMessage.value = 'Failed to sign up: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> signInUser(String phoneNumber) async {
    try {
      isLoading(true);
      var fetchSignIn = await ApiNovel().authSignIn(phoneNumber);
      signIn.value = {
        'phoneNum': fetchSignIn['user']['phoneNumber'],
        'phoneOtp': fetchSignIn['otp'],
      };
      Get.toNamed('/novelOTPValidation', arguments: signIn);
    } catch (e) {
      errorMessage.value = 'Failed to sign in: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp(String phoneNumber, String otpCode) async {
    try {
      isLoading(true);
      await ApiNovel().authOTP(phoneNumber, otpCode);
      codeOTP.value = {
        'phoneNumber': phoneNumber,
        'Code': otpCode,
      };
      Get.offAllNamed('/novelListHome');
    } catch (e) {
      errorMessage.value = 'Failed to verify OTP: $e';
    } finally {
      isLoading(false);
    }
  }
}
