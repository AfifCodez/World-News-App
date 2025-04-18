
import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  final Map article;
  final List otherArticles;

  const NewsDetailPage({super.key, required this.article, required this.otherArticles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['source']['name'] ?? 'News Source'),
        elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']),
            const SizedBox(height: 16),
            Text(
              article['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              article['description'] ?? 'No Description',
              //article['content'] ?? 'No Content Available.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Text('Author: ${article['author'] ?? 'Unknown'}'),
            Text('Published at: ${article['publishedAt'] ?? 'Unknown'}'),
            const Divider(height: 40),
            Text(
              'Other News Suggestions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            ...otherArticles.take(5).map((otherArticle) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: otherArticle['urlToImage'] != null
                              ? Image.network(otherArticle['urlToImage'], width: 100, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported),
              title: Text(otherArticle['title'] ?? 'No Title'),
              subtitle: Text(otherArticle['source']['name'] ?? ''),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailPage(
                      article: otherArticle,
                      otherArticles: otherArticles.where((a) => a != otherArticle).toList(),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}