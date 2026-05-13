# Arena 🏟️

**Arena** is an iOS application for browsing leagues across several sports, viewing recent and upcoming fixtures, exploring teams and squads, and keeping favorite leagues on your device. Built with UIKit and a clear MVP-style structure, Arena focuses on a responsive, readable experience for following competitions.

Developed by **Abdelrahman Waheed**.

## 📸 App Screenshots

| Splash | Onboarding 1 | Onboarding 2 | Sports (light) |
|--------|----------------|----------------|----------------|
| <img src="https://github.com/user-attachments/assets/6dcd7481-4c38-417a-947c-8f2c1d1b52cc" width="220" alt="Splash"/> | <img src="https://github.com/user-attachments/assets/40669641-7f70-40df-921a-3c1ba68d4865" width="220" alt="Onboarding 1"/> | <img src="https://github.com/user-attachments/assets/7605b0b9-1ad4-4c33-9d09-87cb64578a01" width="220" alt="Onboarding 2"/> | <img src="https://github.com/user-attachments/assets/21c1e21b-1bb4-4e46-8d8f-b5de6ff2625c" width="220" alt="Sports home light"/> |

| Sports (dark) | Leagues | League details | League details (fixtures) |
|----------------|---------|------------------|---------------------------|
| <img src="https://github.com/user-attachments/assets/a9fa3def-c61f-41a1-8d20-5d668a0c9997" width="220" alt="Sports home dark"/> | <img src="https://github.com/user-attachments/assets/44d1bee0-bb96-495f-9b02-17e18bd0ad13" width="220" alt="Leagues"/> | <img src="https://github.com/user-attachments/assets/8f3d6cb9-57e3-472f-8b5b-2f2681e1d81c" width="220" alt="League details light"/> | <img src="https://github.com/user-attachments/assets/9c50ad9d-1551-4e29-8fd2-0d773c5b3d95" width="220" alt="League details content"/> |

| Team details (light) | League details (dark) | Team details (dark) | Favorites |
|----------------------|------------------------|---------------------|-----------|
| <img src="https://github.com/user-attachments/assets/b1c5ddcb-b226-4146-86e8-e9e07e60836e" width="220" alt="Team details light"/> | <img src="https://github.com/user-attachments/assets/adb8ba5a-9a38-44cb-ab8b-5b36be0583c6" width="220" alt="League details dark"/> | <img src="https://github.com/user-attachments/assets/2699d384-17e1-4ec3-bda6-c93b15b18e42" width="220" alt="Team details dark"/> | <img src="https://github.com/user-attachments/assets/a7252b66-886a-4153-bcaa-36176b3bf263" width="220" alt="Favorites light"/> |
---

## ✨ Features

### 🔍 Sports & discovery

- **Four sports at a glance:** Football, basketball, tennis, and cricket — each opens its own leagues experience.
- **Live league catalog:** Browse competitions loaded from AllSportsAPI.
- **Quick search:** Filter the grid by league name or country so you find a competition fast.

### 📅 Leagues & matchday

- **Two timeline views:** Fixtures are grouped into **upcoming** and **latest** so you see what is next and what just finished.
- **Team directory:** From a league, open any team to go deeper into that side.
- **Match-ready team screen:** Team overview plus a **squad list** when player data is available from the API.

### ⭐ Favorites & saves

- **One-tap saves:** Star a league to keep it in your personal list — stored locally with Core Data.
- **Offline list:** Scroll your favorites even when you are not online.
- **Smart open:** Jumping from a favorite into full league details checks connectivity so the refreshed fixtures screen does not surprise you mid-load.

### 🌓 First launch & polish

- **Guided intro:** Splash plus a short onboarding flow the first time you open Arena; afterwards the app remembers via `UserDefaults` and drops you straight into the tabs.
- **Light & dark:** Switch appearance from the header and keep the choice between sessions.
- **Reliable networking:** Alamofire for API calls, validation-friendly error handling, and `NWPathMonitor` reachability for connection-sensitive flows.

---

## 🏗️ Project Architecture

Arena follows **MVP-style** separation for features, with a small **composition root** for wiring dependencies.

### UI layer (MVP)

- **Views:** `UIViewController` subclasses and storyboards under `Arena/Modules/` handle layout and user actions.
- **Presenters:** Hold presentation logic, call services, and drive the view through protocols with weak references to avoid retain cycles.
- **Protocols:** Per-feature `*ViewProtocol` and `*PresenterProtocol` types define each screen’s contract.

### Composition and navigation

- **`AppContainer`:** Shared singleton that builds presenters and injects services (`LeaguesService`, `LeagueDetailsService`, `FavoriteLeagueService`), networking (`ApiClient`), `ConnectivityManager`, and `UserDefaultsManager`.
- **`AppRouter`:** Factory methods for splash, onboarding, main navigation, and pushed controllers (leagues, league details, team details), plus animated root transitions in `SceneDelegate`.

### Data layer

- **Remote:** `LeaguesService` and `LeagueDetailsService` call the AllSportsAPI v2 HTTP API through `ApiClient`.
- **Local:** **Core Data** stores favorite leagues (`LeagueEntity`) via `PersistenceController` and `FavoriteLeagueService`.
- **Preferences:** `UserDefaultsManager` stores onboarding completion and dark mode preference.
- **Mappers:** Decodable response models and mappers translate API payloads into app models (`League`, `Event`, `Team`, `Player`, etc.).

---

## 🛠️ Technology Stack

- **Language:** Swift  
- **Minimum iOS (deployment target):** 15.2 — set in the Xcode project; run on a device or simulator with **iOS 15.2 or newer**.  
- **UI:** UIKit, storyboards (Main, Onboarding), nibs (e.g. Splash)  
- **Architecture:** MVP-style modules, lightweight service locator (`AppContainer`)  
- **Networking:** [Alamofire](https://github.com/Alamofire/Alamofire) (`ApiClient`)  
- **Images:** [SDWebImage](https://github.com/SDWebImage/SDWebImage) (Swift Package Manager)  
- **Persistence:** Core Data (`Arena.xcdatamodeld`)  
- **Reachability:** Apple `Network` framework (`NWPathMonitor`)  
- **API:** [AllSportsAPI v2](https://apiv2.allsportsapi.com) — base URL in `ApiConstants`  
- **Typography:** Lexend (bundled fonts, declared in `Info.plist`)  
- **Tests:** `ArenaTests` with `MockApiClient` for service-level tests  

---

## 🚀 Getting Started

### Prerequisites

- macOS with **Xcode** that supports an **iOS 15.2+** SDK (this repo has been built and run on **macOS Big Sur** using the **iPhone SE** simulator). Use a newer macOS / Xcode pair if Apple’s requirements for your simulator image change.
- An **[AllSportsAPI](https://allsportsapi.com/)** API key (the app calls the [v2 API](https://apiv2.allsportsapi.com) for leagues, fixtures, and teams).
- Apple Developer Program membership only if you deploy to a physical device outside of free personal provisioning.

### Clone the repository

```bash
git clone https://github.com/AbdoWa7eed/Arena.git
cd Arena
```

Ongoing work often lives on **`development`**. After cloning, switch if needed:

```bash
git checkout development
```

### API key (build time)

The app reads `API_KEY` from the bundled `Info.plist`, which contains `$(API_KEY)` as a placeholder. You must supply that value at **build time** so Xcode substitutes it into the built app:

1. Open `Arena.xcodeproj` in Xcode.
2. Select the **Arena** target → **Build Settings**.
3. Add a **User-Defined Setting** named `API_KEY` (or use an `.xcconfig` file included by the target) and set its value to your secret key.
4. Do **not** commit real keys to git; keep keys in local xcconfig files listed in `.gitignore` if you use that approach.

If the key is missing or empty at runtime, `ApiConstants` will trap with a clear fatal error.

### Open and run

1. Open `Arena.xcodeproj`.
2. Let Swift Package Manager resolve **Alamofire** and **SDWebImage**.
3. Select the **Arena** scheme and a simulator or device, then run (**⌘R**).

Browsing leagues and fixtures requires **network access**. The favorites **list** is available offline; loading **league details** from a favorite requires connectivity.

### Privacy note

The app contacts **AllSportsAPI** over HTTPS to load sports data. Do not embed API keys in the README or in source files committed to version control.

---

## 👤 Author

**Abdelrahman Waheed**

- **LinkedIn:** [Abdelrahman Waheed](https://www.linkedin.com/in/abdelrahmanwa7eed-dev/)
- **GitHub:** [@AbdoWa7eed](https://github.com/AbdoWa7eed)

---

## 📄 License

This project was developed as part of the **Native Mobile App Development Track** at **ITI (Information Technology Institute)**. Adjust or remove this line if you reuse the project under a different license or context.
