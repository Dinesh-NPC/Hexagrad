# 🎓 Pathora — One-Stop Personalized Career Guidance 
**SIH 2025 Problem Statement ID: 25094**

Pathora is a cross-platform mobile application built with **Flutter**, designed to help students explore career paths, locate colleges, view scholarship opportunities, and make informed academic decisions — all in one place.

---

## 🚀 Features

- 🔐 **Authentication** — Secure login & signup flow  
- 🏫 **Locate Colleges** — Integrated **Google Maps API** to search and view colleges nearby  
- 👤 **Student Profile** — Personalized profile management  
- 💰 **Scholarship Details** — Browse and view available scholarship opportunities  
- 📝 **College Comparison** — Compare multiple colleges based on key parameters  
- 🧠 **Career Assessment** — Basic career assessment to guide students towards suitable paths  
- 🤖 **Chatbot** — Integrated chatbot powered by **Google APIs** for quick assistance and guidance  
- 🔔 **Notifications** — Receive alerts for upcoming competitive exams (demo notification triggers after 5 seconds)

---

## 🛠️ Tech Stack

- **Frontend:** [Flutter](https://flutter.dev/)  
- **Backend / APIs:** Google APIs (Maps, Chatbot), Custom REST APIs  
- **Authentication:** Firebase Authentication  
- **Database:** Firebase Firestore  
- **Other Tools:** Dart, Google Cloud Console

---

## 📲 Screens



## 🌐 APIs Used

- **Google Maps API** – For real-time college location search  
- **Google Dialogflow / Gemini API** – For chatbot functionality  
- **Firebase Authentication & Firestore** – For user data and app backend

---

## 🧭 Project Setup

### 1️⃣ Clone the repository
```bash
git clone https://github.com/your-username/pathora-flutter.git
cd pathora-flutter
```
### 2️⃣ Install dependencies
```bash
flutter pub get
```
### 3️⃣ Add your Google API keys

Go to android/app/src/main/AndroidManifest.xml and add your Maps API key

Set up chatbot API credentials in your .env or config file

### 4️⃣ Run the project
```bash
flutter run
```
