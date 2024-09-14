import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:novel_app/database/api_novel.dart';

class PhoneCodeController extends GetxController {
  var countryCodes = <Map<String, dynamic>>[].obs;
  var selectedCode = 'MY'.obs;
  var selectedGender = 'Male'.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  List<String> genderOpt = <String>[
    'Male',
    'Female',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountryCodes();
  }

  Future<void> fetchCountryCodes() async {
    try {
      isLoading(true);
      var fetchCodeNumber = await ApiNovel().fetchCountryCodes();
      if (fetchCodeNumber.isNotEmpty) {
        countryCodes.value = fetchCodeNumber;
      } else {
        errorMessage.value = 'Data fetch is null';
        debugPrint(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch data: $e';
      debugPrint(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  void updateSelectedCode(String code) {
    selectedCode.value = code;
  }

  void updateSelectedGender(String gender) {
    selectedGender.value = gender;
  }
}
