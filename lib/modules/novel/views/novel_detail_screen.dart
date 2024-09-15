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
    String formatDate(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Obx(
            () {
              if (novelController.isLoadingDetails.value) {
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
                    "Opps Something Wrong\nTry again later",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
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
                        ? Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.teal.shade400,
                              backgroundImage: NetworkImage(
                                  '$domainThumbnail${novel['cover']['formats']['thumbnail']['url']}'),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.teal.shade400,
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          25.0,
                          16.0,
                          25.0,
                          16.0,
                        ),
                        child: SingleChildScrollView(
                          physics: const RangeMaintainingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 10),
                              novel['publication'] != null
                                  ? Text(
                                      'Publication: ${formatDate(novel['publication'])}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  : Text(
                                      "Publication: 'N/A",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                              const SizedBox(height: 10),
                              Text(
                                'Genre: ${novel['genre'] ?? 'N/A'}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Ratings: ${novel['ratings'] ?? 'N/A'}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Summary:',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Html(
                                data:
                                    novel['summary'] ?? 'No summary available',
                                style: {
                                  "body": Style(
                                    color: Colors.teal.shade400,
                                    fontSize: FontSize(12),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    textAlign: TextAlign.justify,
                                  ),
                                },
                              ),
                            ],
                          ),
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
