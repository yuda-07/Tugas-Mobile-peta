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
