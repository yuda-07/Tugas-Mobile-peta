# 🌦️ Aplikasi Cuaca & Peta (Weather & Map)

Aplikasi mobile **Flutter** yang menampilkan data cuaca **real-time** dan peta interaktif. Menggunakan **Open-Meteo API** dan **OpenStreetMap** — **tanpa memerlukan API key berbayar**.

> **Tugas Kuliah Semester 4 — Mata Kuliah Perangkat Bergerak**

---

## 📸 Screenshot

| Tab Cuaca | Tab Peta |
|:---:|:---:|
| <img src="Home.png" alt="Tab Cuaca" width="300"/> | <img src="Peta.png" alt="Tab Peta" width="300"/> |
| Cuaca lokasi saat ini, pencarian kota, prakiraan 7 hari | Peta interaktif OpenStreetMap, tap untuk melihat cuaca |

---

## ✨ Fitur Utama

### 🌡️ Tab Cuaca
- **Deteksi Lokasi Otomatis** — Mendeteksi lokasi user via GPS (fallback ke Jakarta jika gagal)
- **Pencarian Kota** — Cari kota manapun di dunia dengan autocomplete (Bahasa Indonesia)
- **Cuaca Saat Ini** — Suhu, kelembaban, kecepatan angin, dan kondisi cuaca lengkap dengan emoji
- **Prakiraan 7 Hari** — Prakiraan cuaca harian selama seminggu ke depan (scrollable)
- **Pull to Refresh** — Tarik ke bawah untuk memperbarui data cuaca

### 🗺️ Tab Peta
- **Peta Interaktif** — OpenStreetMap yang bisa di-zoom dan digeser
- **Tap untuk Cuaca** — Tap lokasi manapun di peta untuk melihat cuaca di titik tersebut
- **Marker Lokasi** — Marker biru untuk lokasi saat ini dan lokasi yang dipilih
- **Kontrol Peta** — Tombol zoom in/out dan kembali ke lokasi saat ini
- **Bottom Sheet** — Detail cuaca muncul di bottom sheet saat lokasi dipilih

---

## 🛠️ Teknologi yang Digunakan

| Dependency | Versi | Kegunaan |
|---|---|---|
| **Flutter** | 3.x (SDK ^3.11.1) | Framework UI cross-platform |
| **http** | ^1.6.0 | HTTP client untuk API requests |
| **flutter_map** | ^8.3.0 | Widget peta interaktif |
| **latlong2** | ^0.9.1 | Koordinat latitude/longitude |
| **geolocator** | ^14.0.3 | Akses lokasi GPS perangkat |
| **intl** | ^0.20.2 | Format tanggal dan waktu |
| **cupertino_icons** | ^1.0.8 | Ikon gaya iOS |

### API & Layanan Gratis (Tanpa API Key)

| Layanan | URL | Fungsi |
|---|---|---|
| **Open-Meteo Forecast** | `https://api.open-meteo.com/v1/forecast` | Data cuaca real-time + prakiraan 7 hari |
| **Open-Meteo Geocoding** | `https://geocoding-api.open-meteo.com/v1/search` | Pencarian kota berdasarkan nama |
| **OpenStreetMap Tiles** | `https://tile.openstreetmap.org/{z}/{x}/{y}.png` | Tile peta gratis & open-source |

---

## 📁 Struktur Project

```
weather_map_app/
├── lib/
│   ├── main.dart                    # Entry point — MaterialApp + tema biru Material 3
│   ├── models/
│   │   └── weather_model.dart       # 3 model: WeatherData, ForecastData, LocationData
│   ├── services/
│   │   ├── weather_service.dart     # Fetch cuaca & geocoding dari Open-Meteo API
│   │   └── location_service.dart    # Akses GPS + permission lokasi via geolocator
│   ├── screens/
│   │   ├── home_screen.dart         # Bottom navigation bar (2 tab: Cuaca & Peta)
│   │   ├── weather_screen.dart      # Layar cuaca + search bar + prakiraan 7 hari
│   │   └── map_screen.dart          # Layar peta interaktif + cuaca on-tap
│   └── widgets/
│       ├── weather_card.dart        # Card cuaca saat ini (suhu, kelembaban, angin)
│       └── forecast_item.dart       # Item prakiraan harian (tanggal, icon, suhu)
├── android/                         # Build Android
├── ios/                             # Build iOS
├── web/                             # Build Web
├── Home.png                         # Screenshot tab Cuaca
├── Peta.png                         # Screenshot tab Peta
├── pubspec.yaml                     # Konfigurasi dependencies
└── README.md                        # Dokumentasi ini
```

---

## 🚀 Cara Menjalankan

### Prasyarat
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.x+)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/) dengan Flutter plugin
- Android Emulator atau perangkat fisik dengan USB Debugging

### Langkah-langkah

```bash
# 1. Clone repository
git clone <url-repo>
cd weather_map_app

# 2. Install dependencies
flutter pub get

# 3. Cek perangkat
flutter devices

# 4. Jalankan aplikasi
flutter run
```

### Build APK

```bash
flutter build apk --release
```

File APK akan tersedia di:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📊 Model Data

### WeatherData
| Field | Tipe | Keterangan |
|---|---|---|
| `temperature` | `double` | Suhu dalam °C |
| `humidity` | `double` | Kelembaban relatif (%) |
| `windSpeed` | `double` | Kecepatan angin (km/h) |
| `weatherCode` | `int` | Kode cuaca WMO |
| `description` | `String` | Deskripsi cuaca (Bahasa Indonesia) |
| `location` | `String` | Nama lokasi |
| `time` | `DateTime` | Waktu pengambilan data |

### ForecastData
| Field | Tipe | Keterangan |
|---|---|---|
| `date` | `DateTime` | Tanggal prakiraan |
| `tempMax` | `double` | Suhu maksimum (°C) |
| `tempMin` | `double` | Suhu minimum (°C) |
| `weatherCode` | `int` | Kode cuaca WMO |
| `description` | `String` | Deskripsi cuaca |

### LocationData
| Field | Tipe | Keterangan |
|---|---|---|
| `name` | `String` | Nama kota/lokasi |
| `latitude` | `double` | Koordinat lintang |
| `longitude` | `double` | Koordinat bujur |
| `country` | `String?` | Negara |
| `admin1` | `String?` | Provinsi/wilayah |

---

## 🌤️ Kode Cuaca WMO

| Kode | Deskripsi | Emoji |
|:---:|---|:---:|
| 0 | Cerah | ☀️ |
| 1 | Cerah Berawan | 🌤️ |
| 2 | Berawan Sebagian | 🌤️ |
| 3 | Berawan | ☁️ |
| 45, 48 | Berkabut | 🌫️ |
| 51, 53, 55 | Gerimis | 🌦️ |
| 56, 57 | Gerimis Beku | 🌦️ |
| 61, 63, 65 | Hujan | 🌧️ |
| 66, 67 | Hujan Beku | 🌧️ |
| 71, 73, 75 | Salju | 🌨️ |
| 77 | Hujan Salju | 🌨️ |
| 80, 81, 82 | Hujan Lebat | 🌧️ |
| 85, 86 | Hujan Salju Lebat | 🌨️ |
| 95 | Badai Petir | ⛈️ |
| 96, 99 | Badai Petir + Hujan Es | ⛈️ |

---

## 🎮 Cara Menggunakan

### Tab Cuaca
1. Buka aplikasi → tab **Cuaca** otomatis terbuka
2. Izinkan akses lokasi jika diminta (aplikasi otomatis deteksi GPS)
3. Gunakan **search bar** untuk mencari kota (contoh: "Jakarta", "Bandung", "Tokyo")
4. Pilih kota dari hasil pencarian
5. Geser **prakiraan 7 hari** untuk lihat cuaca hari berikutnya
6. **Tarik ke bawah** untuk refresh data

### Tab Peta
1. Tap tab **Peta** di bottom navigation
2. Peta menampilkan lokasi Anda (marker biru)
3. **Tap dimana saja** pada peta untuk lihat cuaca
4. Info cuaca muncul di **bottom sheet**
5. Tombol **bulat biru** → kembali ke lokasi Anda
6. Tombol **+/-** → zoom in/out

---

## ⚠️ Troubleshooting

| Masalah | Solusi |
|---|---|
| Lokasi tidak terdeteksi | Izinkan akses lokasi + pastikan GPS aktif |
| Peta tidak muncul | Cek koneksi internet (tile OSM butuh internet) |
| Data cuaca gagal dimuat | Cek koneksi, pull-to-refresh untuk coba lagi |
| `flutter: command not found` | Install Flutter SDK + tambahkan ke PATH |
| Build gagal | `flutter clean` lalu `flutter pub get` |
| Emulator tidak ditemukan | Android Studio → Device Manager → buat emulator baru |
| `INSTALL_FAILED_INSUFFICIENT_STORAGE` | Wipe data emulator atau hapus app lama |

---

## 📜 Lisensi

Project ini dibuat untuk keperluan **tugas kuliah Semester 4 — Mata Kuliah Perangkat Bergerak**.

---

*Dibuat dengan Flutter, Open-Meteo API & OpenStreetMap* 🚀
# Weather & Map App

Aplikasi Flutter untuk menampilkan informasi cuaca real-time dan peta interaktif. Dibangun sebagai tugas mata kuliah Perangkat Bergerak, Semester 4.

## Screenshot

| Halaman Cuaca | Halaman Peta |
|:---:|:---:|
| ![Home](Home.png) | ![Peta](Peta.png) |

## Fitur Utama

### Halaman Cuaca
- Menampilkan cuaca saat ini berdasarkan lokasi pengguna (suhu, kelembaban, kecepatan angin)
- Prakiraan cuaca 7 hari ke depan dalam format horizontal scroll
- Pencarian kota dengan autocomplete menggunakan Open-Meteo Geocoding API
- Pull-to-refresh untuk memuat ulang data cuaca
- Fallback ke Jakarta jika lokasi tidak tersedia

### Halaman Peta
- Peta interaktif menggunakan OpenStreetMap (via `flutter_map`)
- Tap pada peta untuk melihat cuaca di lokasi tertentu
- Tombol navigasi ke lokasi saat ini
- Kontrol zoom in/out
- Popup informasi cuaca (suhu, deskripsi, kelembaban, angin) pada lokasi yang dipilih

## Tech Stack

| Teknologi | Keterangan |
|---|---|
| **Flutter** | Framework UI cross-platform |
| **Dart** | Bahasa pemrograman (SDK ^3.11.1) |
| **http** | HTTP client untuk API calls |
| **flutter_map** | Rendering peta OpenStreetMap |
| **latlong2** | Library koordinat geografis |
| **geolocator** | Akses lokasi GPS perangkat |
| **intl** | Formatting tanggal dan waktu |

## API

Aplikasi ini menggunakan **Open-Meteo API** (gratis, tanpa API key):

- **Weather Forecast**: `https://api.open-meteo.com/v1/forecast`
- **Geocoding**: `https://geocoding-api.open-meteo.com/v1/search`

## Struktur Proyek

```
lib/
├── main.dart                   # Entry point aplikasi
├── models/
│   └── weather_model.dart      # Model data: WeatherData, ForecastData, LocationData
├── screens/
│   ├── home_screen.dart        # Bottom navigation (Cuaca & Peta)
│   ├── weather_screen.dart     # Halaman cuaca + pencarian kota
│   └── map_screen.dart         # Halaman peta interaktif
├── services/
│   ├── weather_service.dart    # Service API cuaca & geocoding
│   └── location_service.dart   # Service GPS & perizinan lokasi
└── widgets/
    ├── weather_card.dart       # Kartu cuaca utama (gradient biru)
    └── forecast_item.dart      # Item prakiraan harian
```

## Instalasi

### Prasyarat
- Flutter SDK >= 3.11.1
- Android Studio / VS Code
- Emulator Android atau perangkat fisik

### Langkah-langkah

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd weather_map_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

4. **Build APK (release)**
   ```bash
   flutter build apk
   ```
   Output: `build/app/outputs/flutter-apk/app-release.apk`

## Model Data

### WeatherData
| Field | Tipe | Keterangan |
|---|---|---|
| `temperature` | `double` | Suhu dalam °C |
| `humidity` | `double` | Kelembaban (%) |
| `windSpeed` | `double` | Kecepatan angin (km/h) |
| `weatherCode` | `int` | Kode cuaca dari API |
| `description` | `String` | Deskripsi cuaca (Bahasa Indonesia) |
| `location` | `String` | Nama lokasi |

### ForecastData
| Field | Tipe | Keterangan |
|---|---|---|
| `date` | `DateTime` | Tanggal prakiraan |
| `tempMax` | `double` | Suhu maksimum (°C) |
| `tempMin` | `double` | Suhu minimum (°C) |
| `weatherCode` | `int` | Kode cuaca dari API |
| `description` | `String` | Deskripsi cuaca |

### LocationData
| Field | Tipe | Keterangan |
|---|---|---|
| `name` | `String` | Nama kota/lokasi |
| `latitude` | `double` | Koordinat lintang |
| `longitude` | `double` | Koordinat bujur |
| `country` | `String?` | Nama negara |
| `admin1` | `String?` | Provinsi/wilayah |

## Kode Cuaca (WMO)

| Kode | Deskripsi | Ikon |
|---|---|---|
| 0 | Cerah | ☀️ |
| 1-2 | Cerah Berawan | 🌤️ |
| 3 | Berawan | ☁️ |
| 45-48 | Berkabut | 🌫️ |
| 51-57 | Gerimis | 🌦️ |
| 61-67 | Hujan | 🌧️ |
| 71-77 | Salju | 🌨️ |
| 80-82 | Hujan Lebat | 🌧️ |
| 85-86 | Hujan Salju Lebat | 🌨️ |
| 95-99 | Badai Petir | ⛈️ |

## Lisensi

Proyek ini dibuat untuk tujuan pendidikan.
# Aplikasi Cuaca & Peta (Weather & Map)

Aplikasi mobile Flutter yang menampilkan data cuaca real-time dan peta interaktif. Menggunakan Open-Meteo API dan OpenStreetMap - **tanpa memerlukan API key berbayar**.

## Screenshot Fitur

| Tab Cuaca | Tab Peta |
|-----------|----------|
| Lihat cuaca lokasi saat ini & cari kota manapun | Peta interaktif, tap untuk lihat cuaca |

## Fitur Utama

### Tab Cuaca
- **Deteksi Lokasi Otomatis** - Mendeteksi lokasi user via GPS (fallback ke Jakarta jika gagal)
- **Pencarian Kota** - Cari kota manapun di dunia dengan autocomplete
- **Cuaca Saat Ini** - Menampilkan suhu, kelembaban, kecepatan angin, dan kondisi cuaca
- **Prakiraan 7 Hari** - Prakiraan cuaca harian selama seminggu ke depan
- **Pull to Refresh** - Tarik ke bawah untuk memperbarui data cuaca

### Tab Peta
- **Peta Interaktif** - Peta OpenStreetMap yang bisa di-zoom dan digeser
- **Tap untuk Cuaca** - Tap lokasi di peta untuk melihat cuaca di titik tersebut
- **Marker Lokasi** - Menampilkan marker lokasi saat ini dan lokasi yang dipilih
- **Kontrol Peta** - Tombol zoom in/out dan kembali ke lokasi saat ini
- **Popup Info Cuaca** - Detail cuaca muncul di bottom sheet saat lokasi dipilih

## Teknologi yang Digunakan

| Teknologi | Kegunaan |
|-----------|----------|
| **Flutter 3.x** | Framework UI cross-platform |
| **Open-Meteo API** | Data cuaca gratis tanpa API key |
| **Open-Meteo Geocoding** | Pencarian lokasi/kota |
| **OpenStreetMap** | Tile peta gratis dan open-source |
| **flutter_map** | Widget peta interaktif untuk Flutter |
| **geolocator** | Akses lokasi GPS user |
| **http** | HTTP client untuk API requests |
| **latlong2** | Handling koordinat latitude/longitude |
| **intl** | Format tanggal dan waktu |
| **Material Design 3** | UI modern dengan tema biru |

## Prasyarat

Sebelum menjalankan aplikasi, pastikan Anda sudah menginstall:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.x atau lebih baru)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/) dengan Flutter plugin
- Android Emulator atau perangkat Android fisik dengan USB Debugging aktif
- (Opsional) Xcode untuk menjalankan di iOS

## Langkah-langkah Menjalankan Aplikasi

### 1. Clone Repository

```bash
git clone https://github.com/username/repo-name.git
cd repo-name/weather_map_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Cek Perangkat yang Terhubung

```bash
flutter devices
```

Pastikan ada emulator atau perangkat yang muncul di daftar. Jika belum:
- **Android Emulator**: Buka Android Studio > Tools > Device Manager > Buat emulator baru
- **Perangkat Fisik**: Aktifkan USB Debugging di Settings > Developer Options

### 4. Jalankan Aplikasi

```bash
flutter run
```

Atau untuk mode release:

```bash
flutter run --release
```

### 5. (Opsional) Build APK

Untuk membuat file APK yang bisa diinstall di perangkat Android:

```bash
flutter build apk --release
```

File APK akan tersedia di:
```
build/app/outputs/flutter-apk/app-release.apk
```

## Cara Menggunakan Aplikasi

### Menggunakan Tab Cuaca
1. Buka aplikasi, tab **Cuaca** akan otomatis terbuka
2. Aplikasi akan mendeteksi lokasi Anda secara otomatis (izinkan akses lokasi jika diminta)
3. Gunakan **search bar** di atas untuk mencari kota lain (contoh: "Jakarta", "Bandung", "Tokyo")
4. Pilih kota dari hasil pencarian untuk melihat cuaca di kota tersebut
5. Geser **prakiraan 7 hari** di bagian bawah untuk melihat cuaca hari-hari berikutnya
6. Tarik layar ke bawah untuk **refresh** data cuaca

### Menggunakan Tab Peta
1. Tap tab **Peta** di bottom navigation bar
2. Peta akan menampilkan lokasi Anda saat ini (marker biru)
3. **Tap di mana saja** pada peta untuk melihat cuaca di lokasi tersebut
4. Info cuaca akan muncul di **bottom sheet** dengan detail suhu dan kondisi
5. Gunakan tombol **bulat biru** (kanan atas) untuk kembali ke lokasi Anda
6. Gunakan tombol **+/-** untuk zoom in/out peta

## Struktur Project

```
weather_map_app/
├── lib/
│   ├── models/
│   │   └── weather_model.dart       # Model: WeatherData, ForecastData, LocationData
│   ├── services/
│   │   ├── weather_service.dart     # Service: fetch cuaca & geocoding dari Open-Meteo
│   │   └── location_service.dart    # Service: akses GPS & permission lokasi
│   ├── screens/
│   │   ├── home_screen.dart         # Bottom navigation (Cuaca & Peta tabs)
│   │   ├── weather_screen.dart      # Layar cuaca + search + forecast
│   │   └── map_screen.dart          # Layar peta interaktif + cuaca on-tap
│   ├── widgets/
│   │   ├── weather_card.dart        # Komponen card cuaca saat ini
│   │   └── forecast_item.dart       # Komponen item prakiraan harian
│   └── main.dart                    # Entry point aplikasi
├── pubspec.yaml                     # Konfigurasi dependencies
└── README.md                        # Dokumentasi ini
```

## Sumber Data

### Open-Meteo API
- **Website**: https://open-meteo.com/
- **Gratis** dan **tanpa API key**
- Data cuaca real-time dan prakiraan
- Mendukung geocoding (pencarian lokasi berdasarkan nama kota)

### OpenStreetMap
- **Website**: https://www.openstreetmap.org/
- Tile peta gratis dan open-source
- Cakupan global

## Troubleshooting

| Masalah | Solusi |
|---------|--------|
| Lokasi tidak terdeteksi | Pastikan izin lokasi diberikan dan GPS aktif |
| Peta tidak muncul | Cek koneksi internet, tile OSM membutuhkan internet |
| Data cuaca gagal dimuat | Cek koneksi internet, pull-to-refresh untuk coba lagi |
| `flutter: command not found` | Install Flutter SDK dan tambahkan ke PATH |
| Build gagal | Jalankan `flutter clean` lalu `flutter pub get` |
| Emulator tidak ditemukan | Buka Android Studio > Device Manager > buat emulator baru |

## Lisensi

Project ini dibuat untuk keperluan tugas kuliah Semester 4 - Perangkat Bergerak.

---

Dibuat dengan Flutter & Open-Meteo API
