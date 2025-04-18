🗞️ Flutter News App

A simple and beautiful **Flutter News App** that displays top headlines using the [NewsAPI](https://newsapi.org). Users can browse news by category, view detailed articles, and bookmark their favorite articles.

📱 Features

- 🔥 Top headlines fetched from NewsAPI
- 🗂️ News by categories: General, Business, Entertainment, Health, Science, Sports, Technology
- 📖 News detail view with content, image, and metadata
- 📌 Bookmark functionality with persistent storage
- 💡 Dark and light theme support
- 📲 Pull-to-refresh support
- 📰 Suggested news articles on detail page

📸 Screenshots

| Home Page | Categories | News Details | Bookmarks |
|----------|------------|---------------|------------|
| ![Home](![WhatsApp Image 2025-04-18 at 12 21 12_5b3a374b](https://github.com/user-attachments/assets/9c69bc1d-fcbf-4da7-9774-a65211df66f6)) | ![Categories](![WhatsApp Image 2025-04-18 at 12 21 12_784a8194](https://github.com/user-attachments/assets/46fd4a48-a2fe-427e-a4f5-e85980d5842d)) | ![Details](![WhatsApp Image 2025-04-18 at 12 21 14_62ba780a](https://github.com/user-attachments/assets/c0332048-ff53-4da9-bfe3-81741b6a5507)) | ![Bookmarks](![WhatsApp Image 2025-04-18 at 12 21 14_d1387358](https://github.com/user-attachments/assets/aee021a2-bda4-4a87-8f5a-33dadfb47bfe)) |


🚀 Getting Started

1. Clone the repository

bash
git clone https://github.com/your-username/flutter-news-app.git
cd flutter-news-app

2. Install dependencies

bash
flutter pub get


3. Run the app

bash
flutter run

🔑 Setup API Key

This app uses [NewsAPI](https://newsapi.org). You need an API key to fetch news.

1. Get your API key from [https://newsapi.org/register](https://newsapi.org/register)
2. Replace the existing API key inside the code:

dart
main.dart
const String apiKey = 'your_api_key_here';

📦 Packages Used

- [`http`](https://pub.dev/packages/http) - For API requests
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) - For saving bookmarks locally


📁 Folder Structure

bash
/lib
  └── main.dart          # Main application file
/assets
  └── screenshots/       # Optional screenshots for README

🛠️ TODO

- [ ] Add search functionality
- [ ] Add offline article saving
- [ ] Add animations and loading shimmer
- [ ] Add article sharing feature
- [ ] Firebase login for personal bookmarks

👨‍💻 Author

**MUHAMMAD AFIF** – [@AfifCodez](https://github.com/AfifCodez)

📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
