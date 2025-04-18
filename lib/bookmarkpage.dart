import 'package:flutter/material.dart';
import 'package:world_news_app/newsdetailpage.dart';

class BookmarkPage extends StatefulWidget {
  final Set<String> bookmarkedTitles;
  final List allArticles;
  final Function(String) onToggleBookmark;

  const BookmarkPage({super.key, required this.bookmarkedTitles, required this.allArticles, required this.onToggleBookmark});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles = widget.allArticles.where((article) => widget.bookmarkedTitles.contains(article['title'])).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Articles')),
      body: bookmarkedArticles.isEmpty
          ? const Center(child: Text('No bookmarks yet'))
          : ListView.builder(
              itemCount: bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = bookmarkedArticles[index];
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
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark_remove),
                      onPressed: () {
                        widget.onToggleBookmark(title);
                        setState(() {});
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailPage(
                            article: article,
                            otherArticles: bookmarkedArticles.where((a) => a != article).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
