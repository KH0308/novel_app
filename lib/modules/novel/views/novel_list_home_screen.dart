import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/novel_controller.dart';
import 'search_novel.dart';

class NovelListHomeScreen extends StatelessWidget {
  NovelListHomeScreen({super.key});
  final NovelController novelController = Get.put(NovelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                child: RichText(
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
                        text: 'Bibliophile',
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
                      context: context, delegate: CustomSearchDelegateWidget());
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
              Obx(() {
                if (novelController.isLoading.value) {
                  return Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal.shade400,
                        strokeWidth: 6.0,
                        strokeCap: StrokeCap.round,
                        valueColor: const AlwaysStoppedAnimation(
                          Colors.black,
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

                return ListView.builder(
                  itemCount: novelController.novels.length,
                  itemBuilder: (context, index) {
                    var novel = novelController.novels[index];
                    return ListTile(
                      tileColor: Colors.orange.shade100,
                      title: Text(
                        novel['data']['title'],
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            novel['data']['author'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            novel['data']['genre'],
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            novel['data']['rating'],
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      leading: novel['data']['cover']['formats']['thumbnail'] !=
                              null
                          ? Image.network(
                              novel['data']['cover']['formats']['thumbnail'])
                          : const Icon(Icons.book),
                      onTap: () {
                        novelController.goToDetailPage(novel['data']['id']);
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
