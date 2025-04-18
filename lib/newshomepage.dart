import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_news_app/bookmarkpage.dart';
import 'package:world_news_app/newsdetailpage.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List articles = [];
  bool isLoading = true;
  String selectedCategory = 'GENERAL';
  Set<String> bookmarkedTitles = {};

  final categories = [
    'GENERAL', 'BUSINESS', 'ENTERTAINMENT', 'HEALTH', 'SCIENCE', 'SPORTS', 'TECHNOLOGY'
  ];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
    fetchNews();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedTitles = prefs.getStringList('bookmarks')?.toSet() ?? {};
    });
  }

  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarks', bookmarkedTitles.toList());
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$selectedCategory&apiKey=d30b25e9b4394502b0019fbf18eb9010');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        articles = data['articles'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  void toggleBookmark(String title) {
    setState(() {
      if (bookmarkedTitles.contains(title)) {
        bookmarkedTitles.remove(title);
      } else {
        bookmarkedTitles.add(title);
      }
      saveBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookmarkPage(
                    bookmarkedTitles: bookmarkedTitles,
                    allArticles: articles,
                    onToggleBookmark: toggleBookmark,
                  ),
                ),
              );
              setState(() {}); // Refresh on return
            },
            
          ),
          
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: selectedCategory == cat,
                  onSelected: (_) {
                    setState(() => selectedCategory = cat);
                    fetchNews();
                  },
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: fetchNews,
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      final title = article['title'] ?? 'No Title';
                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: article['urlToImage'] != null
                              ? Image.network(article['urlToImage'], width: 100, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported),
                          title: Text(title),
                          //subtitle: Text(article['description'] ?? 'No Description'),
                          trailing: IconButton(
                            icon: Icon(bookmarkedTitles.contains(title)
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            onPressed: () => toggleBookmark(title),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  article: article,
                                  otherArticles: articles.where((a) => a != article).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }
}