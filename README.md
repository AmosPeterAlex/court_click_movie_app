# Netflix Clone (Movie App)

A Netflix clone mobile app built with Flutter. It displays movies and TV shows using The Movie Database (TMDB) API.

---

## What the App Does

- **Home Screen**: Shows a featured hero movie banner, a previews row, and movie rails (Trending Now, Popular, Now Playing, Top Rated).
- **Search**: Search for any movie with quick results, or browse popular top searches.
- **Coming Soon**: View upcoming movie trailers and release dates with quick "Remind Me" and "Share" options.
- **Profiles & Settings**: Choose or switch user profiles, download settings, and more.

---

## Packages Used

Here are the main Flutter packages used in this project and why they are used:

- **`flutter_bloc`**: Manages the app state cleanly (loading, loaded, error, empty).
- **`get_it`**: A service locator that provides dependencies (like API services and repositories) across the app.
- **`dio`**: Handles all network requests to TMDB with timeout settings and logging.
- **`go_router`**: Handles screen navigation and routing smoothly.
- **`cached_network_image`**: Downloads and caches movie posters so they load fast and work offline.
- **`shimmer`**: Shows animated loading placeholder skeletons while data loads.
- **`equatable`**: Helps compare state objects in BLoC without boilerplate code.
- **`cupertino_icons`**: Provides icons for the user interface.

---

## Getting Started & Setup

Follow these simple steps to set up and run the app on your computer.

### Prerequisites

Make sure you have installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.10 or higher)
- Android Studio, VS Code, or a connected physical Android/iOS phone

---

### Step 1: Clone the repository

```bash
git clone https://github.com/AmosPeterAlex/court_click_movie_app.git
cd court_click_movie_app
```

### Step 2: Install dependencies

Run this command in the project folder to download all required packages:

```bash
flutter pub get
```

---

## How to Add Your TMDB API Key

To keep secrets safe, the API key is never committed to GitHub. You can add your API key in one of two simple ways:

### Method 1: Using `config.json` (Easiest & Recommended)

1. Make a copy of `config.json.example` and name it `config.json`:
   - On Windows (PowerShell):
     ```powershell
     Copy-Item config.json.example config.json
     ```
   - On Mac / Linux:
     ```bash
     cp config.json.example config.json
     ```

2. Open `config.json` in your editor and paste your TMDB API key:
   ```json
   {
     "TMDB_API_KEY": "your_api_key_here",
     "TMDB_TOKEN": "your_bearer_token_here"
   }
   ```

3. Run the app:
   ```bash
   flutter run --dart-define-from-file=config.json
   ```

---

### Method 2: Passing the Key in the Terminal

If you prefer not to create a file, you can pass your API key directly in your terminal command:

```bash
flutter run --dart-define=TMDB_API_KEY=your_api_key_here
```

---

## Running the App

### Run in Debug Mode
```bash
flutter run --dart-define-from-file=config.json
```

### Run in Release Mode
```bash
flutter run --release --dart-define-from-file=config.json
```

### Build a Release APK (Android)
```bash
flutter build apk --release --dart-define-from-file=config.json
```
The finished APK file will be at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## Running Tests

To verify that all tests pass:

```bash
flutter test
```

To check for any code or lint issues:

```bash
flutter analyze
```
