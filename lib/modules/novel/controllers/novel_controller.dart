import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/api_novel.dart';

class NovelController extends GetxController {
  var novels = [].obs;
  var novelDetails = {}.obs;
  var isLoading = false.obs;
  var isLoadingDetails = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNovels();
    super.onInit();
  }

  Future<void> fetchNovels() async {
    errorMessage.value = '';
    try {
      isLoading(true);
      var fetchedNovels = await ApiNovel().fetchNovelLists();
      if (fetchedNovels.isNotEmpty) {
        novels.value = fetchedNovels;
        isLoading.value = false;
      } else {
        errorMessage.value = 'Data is empty';
        isLoading.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load novels: $e';
      debugPrint(errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchNovelDetails(String novelId) async {
    errorMessage.value = '';
    try {
      isLoadingDetails(true);
      var details = await ApiNovel().fetchNovelDetails(novelId);
      if (details.isNotEmpty) {
        novelDetails.value = details;
        isLoadingDetails.value = false;
      } else {
        errorMessage.value = 'Data is empty';
        isLoadingDetails.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load novel details: $e';
    } finally {
      isLoadingDetails(false);
    }
  }

  void goToDetailPage(String novelID) async {
    await fetchNovelDetails(novelID);
    Get.toNamed('/novelDetail', arguments: novelID);
  }
}
