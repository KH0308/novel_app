import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/novel_controller.dart';
import 'search_novel.dart';

class NovelListHomeScreen extends StatelessWidget {
  NovelListHomeScreen({super.key});
  final NovelController novelController = Get.put(NovelController());
  final PageController pageController = PageController();
  final domainThumbnail = 'https://test-api.kacs.my';
  final int itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '...............',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.transparent,
                          ),
                        ),
                        TextSpan(
                          text: '\nBibliophile',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegateWidget());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.teal.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Search here...',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RefreshIndicator(
                  color: Colors.teal.shade400,
                  backgroundColor: Colors.orange.shade100,
                  onRefresh: novelController.fetchNovels,
                  child: Obx(() {
                    if (novelController.isLoading.value) {
                      return Container(
                        color: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey.shade200,
                            strokeWidth: 4.0,
                            strokeCap: StrokeCap.round,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.teal.shade400,
                            ),
                          ),
                        ),
                      );
                    }

                    if (novelController.errorMessage.value.isNotEmpty) {
                      return Center(
                        child: Text(
                          novelController.errorMessage.value,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }

                    int totalPages =
                        (novelController.novels.length / itemsPerPage).ceil();

                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.62,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: totalPages,
                              itemBuilder: (context, pageIndex) {
                                int startIndex = pageIndex * itemsPerPage;
                                int endIndex = (startIndex + itemsPerPage >
                                        novelController.novels.length)
                                    ? novelController.novels.length
                                    : startIndex + itemsPerPage;
                                var novelsPage = novelController.novels
                                    .sublist(startIndex, endIndex);

                                return ListView.separated(
                                  itemCount: novelsPage.length,
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.teal.shade400,
                                  ),
                                  itemBuilder: (context, index) {
                                    var novel = novelsPage[index];
                                    return Card(
                                      color: Colors.grey.shade100,
                                      child: ListTile(
                                        title: Text(
                                          novel['title'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              novel['author'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              novel['genre'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '${novel['ratings'].toString()}/10',
                                              style: GoogleFonts.poppins(
                                                color: Colors.yellow.shade700,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        leading: novel['cover']['formats']
                                                    ['thumbnail'] !=
                                                null
                                            ? CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                  '$domainThumbnail${novel['cover']['formats']['thumbnail']['url']}',
                                                ),
                                              )
                                            : Icon(
                                                Icons.book,
                                                color: Colors.teal.shade400,
                                              ),
                                        onTap: () {
                                          novelController.goToDetailPage(
                                              novel['id'].toString());
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: totalPages,
                              effect: ScrollingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.teal.shade400,
                                dotColor: Colors.grey.shade300,
                                spacing: 10,
                                strokeWidth: 2,
                                maxVisibleDots: 5,
                                fixedCenter: false,
                                radius: 8,
                                paintStyle: PaintingStyle.stroke,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
