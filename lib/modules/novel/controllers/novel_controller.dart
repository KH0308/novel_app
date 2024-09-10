import 'package:get/get.dart';

import '../../../database/api_novel.dart';

class NovelController extends GetxController {
  var novels = [].obs;
  var novelDetails = {}.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNovels();
    super.onInit();
  }

  void fetchNovels() async {
    try {
      isLoading(true);
      var fetchedNovels = await ApiNovel().fetchNovelLists();
      novels.value = fetchedNovels;
    } catch (e) {
      errorMessage.value = 'Failed to load novels: $e';
    } finally {
      isLoading(false);
    }
  }

  void fetchNovelDetails(String novelId) async {
    try {
      isLoading(true);
      var details = await ApiNovel().fetchNovelDetails(novelId);
      novelDetails.value = details;
    } catch (e) {
      errorMessage.value = 'Failed to load novel details: $e';
    } finally {
      isLoading(false);
    }
  }

  void goToDetailPage(String novelID) {
    Get.toNamed('/novelDetail', arguments: novelID);
  }
}
