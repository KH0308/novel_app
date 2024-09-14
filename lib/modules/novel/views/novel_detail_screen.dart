import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/novel_controller.dart';

class NovelDetailsScreen extends StatelessWidget {
  NovelDetailsScreen({super.key});
  final NovelController novelController = Get.put(NovelController());
  final domainThumbnail = 'https://test-api.kacs.my';

  @override
  Widget build(BuildContext context) {
    final novelId = Get.arguments;

    novelController.fetchNovelDetails(novelId);

    String formatDate(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    }

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
          child: Obx(
            () {
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

              var novel = novelController.novelDetails;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    novel['cover']['formats']['thumbnail']['url'] != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.teal.shade400,
                            child: ClipOval(
                              child: Image.network(
                                '$domainThumbnail${novel['cover']['formats']['thumbnail']['url']}',
                              ),
                            ),
                          )
                        : const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Icon(
                                Icons.book_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.70,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade400,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const RangeMaintainingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              novel['title'] ?? 'No Title',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Author: ${novel['author'] ?? 'Unknown'}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            novel['publication'] != null
                                ? Text(
                                    'Publication: ${formatDate(novel['publication'])}',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    "Publication: 'N/A",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                            const SizedBox(height: 10),
                            Text(
                              'Genre: ${novel['genre'] ?? 'N/A'}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Ratings: ${novel['ratings'] ?? 'N/A'}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Summary:',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Html(
                              data: novel['summary'] ?? 'No summary available',
                              style: {
                                "body": Style(
                                  color: Colors.grey,
                                  fontSize: FontSize(12),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
