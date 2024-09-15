import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:novel_app/database/api_novel.dart';

import '../controllers/novel_controller.dart';

class CustomSearchDelegateWidget extends SearchDelegate<String> {
  final ApiNovel apiNovel = ApiNovel();
  List novelList = [];
  final NovelController novelController = Get.put(NovelController());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
      hintColor: Colors.grey.shade200,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal.shade400,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        outlineBorder: BorderSide.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  InputDecorationTheme? inputDecorationTheme = const InputDecorationTheme(
    border: InputBorder.none, // Remove underline
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: Colors.white,
          ),
          onPressed: () => query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('Search Results for: $query'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchSuggestions(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No suggestions found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          );
        } else {
          final List<Map<String, dynamic>> suggestions = snapshot.data!;
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.teal.shade400, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  leading: suggestion['thumbnail'] != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            suggestion['thumbnail'],
                          ),
                        )
                      : Icon(
                          Icons.book,
                          color: Colors.teal.shade400,
                        ),
                  title: Text(
                    suggestion['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Author: ${suggestion['author']}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Genre: ${suggestion['genre']}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Rating: ${suggestion['rating']}/10",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    novelController.goToDetailPage(suggestion['id']);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchSuggestions(String query) async {
    final List<dynamic> novelData = await apiNovel.fetchNovelLists();
    const thumbnailDomain = 'https://test-api.kacs.my';

    final List<Map<String, dynamic>> suggestions = novelData
        .where((novels) => novels['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .map<Map<String, dynamic>>((novels) => {
              'id': novels['id'],
              'title': novels['title'],
              'genre': novels['genre'],
              'rating': novels['ratings'],
              'author': novels['author'],
              'thumbnail':
                  '$thumbnailDomain${novels['cover']['formats']['thumbnail']['url']}',
            })
        .toList();

    return suggestions;
  }
}
