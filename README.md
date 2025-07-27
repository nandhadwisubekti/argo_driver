# Argo Driver App

Aplikasi Flutter untuk menghitung tarif Argo Driver berdasarkan jarak yang ditempuh.

## Fitur Utama

### 🔐 Autentikasi
- **Login Page**: Formulir login dengan email dan password
- **Register Page**: Formulir registrasi dengan nama, email, dan password
- **Splash Screen**: Layar pembuka dengan pengecekan status login otomatis

### 🏠 Halaman Utama (Home)
- **Header**: Logo aplikasi dan tombol logout
- **Pilihan Kendaraan**: Radio button untuk memilih Motor atau Mobil
- **Input Jarak**: Field untuk memasukkan total kilometer perjalanan
- **Input Diskon**: Field opsional untuk memasukkan persentase diskon
- **Perhitungan Tarif Otomatis**: 
  - **Motor**: 
    - ≤ 5km: Rp 10.000 (tarif tetap)
    - > 5km: Rp 10.000 + (total_km × Rp 1.800)
  - **Mobil**: 
    - ≤ 4km: Rp 30.000 (tarif tetap)
    - > 4km: Rp 30.000 + (total_km × Rp 8.000)
- **Hasil Perhitungan**: Menampilkan detail tarif dasar, diskon, dan total akhir
- **Informasi Tarif**: Panel informasi tentang struktur tarif

### ⚙️ Halaman Pengaturan (Setting)
- **Informasi Akun**: Tampilan nama dan email pengguna
- **Ubah Password**: Dialog untuk mengganti password
- **Preferensi Aplikasi**:
  - Toggle notifikasi
  - Toggle mode gelap
  - Pilihan bahasa (Indonesia/English)
- **Tentang Aplikasi**: Versi aplikasi dan bantuan
- **Logout**: Tombol keluar dari aplikasi

### 👤 Halaman Profil (Profile)
- **Header Profil**: Foto profil, nama, email, dan tanggal bergabung
- **Edit Profil**: Dialog untuk mengubah nama dan email
- **Statistik Pengguna**:
  - Total perjalanan
  - Total jarak tempuh
  - Total pendapatan
- **Menu Profil**:
  - Riwayat perjalanan
  - Rating & ulasan
  - Metode pembayaran
  - Bantuan & dukungan

### 📱 Navigasi
- **Bottom Navigation Bar**: Navigasi antar halaman Home, Setting, dan Profile
- **Persistent State**: Status login tersimpan menggunakan SharedPreferences

## Teknologi yang Digunakan

- **Flutter**: Framework utama untuk pengembangan aplikasi
- **Dart**: Bahasa pemrograman
- **SharedPreferences**: Penyimpanan data lokal untuk preferensi pengguna
- **Material Design**: Desain UI yang modern dan responsif

## Struktur Proyek

```
argo_driver_app/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   └── screens/
│       ├── login_page.dart       # Halaman login
│       ├── register_page.dart    # Halaman registrasi
│       ├── home_page.dart        # Halaman utama
│       ├── setting_page.dart     # Halaman pengaturan
│       └── profile_page.dart     # Halaman profil
├── assets/
│   └── images/                   # Folder untuk gambar
├── pubspec.yaml                  # Konfigurasi dependencies
└── README.md                     # Dokumentasi proyek
```

## Cara Menjalankan Aplikasi

### Prasyarat
- Flutter SDK (versi 2.19.0 atau lebih baru)
- Dart SDK
- Android Studio atau VS Code dengan ekstensi Flutter
- Emulator Android atau perangkat fisik

### Langkah-langkah

1. **Clone atau download proyek ini**

2. **Masuk ke direktori proyek**
   ```bash
   cd argo_driver_app
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

## Dependencies

- `flutter`: SDK Flutter
- `cupertino_icons`: Icon set untuk iOS
- `shared_preferences`: Penyimpanan data lokal
- `flutter_lints`: Linting rules untuk kode yang bersih

## Fitur Keamanan

- **Validasi Input**: Semua form memiliki validasi input yang komprehensif
- **Password Security**: Password disembunyikan dengan opsi show/hide
- **Session Management**: Status login dikelola dengan aman menggunakan SharedPreferences
- **Logout Confirmation**: Konfirmasi sebelum logout untuk mencegah logout tidak sengaja

## UI/UX Features

- **Modern Design**: Menggunakan Material Design dengan gradient dan shadow
- **Responsive Layout**: Tampilan yang responsif untuk berbagai ukuran layar
- **Loading States**: Indikator loading untuk operasi async
- **Error Handling**: Pesan error yang informatif
- **Smooth Navigation**: Transisi halaman yang smooth
- **Consistent Theming**: Tema warna yang konsisten di seluruh aplikasi

## Kontribusi

Untuk berkontribusi pada proyek ini:
1. Fork repository
2. Buat branch fitur baru
3. Commit perubahan Anda
4. Push ke branch
5. Buat Pull Request

## Lisensi

Proyek ini dibuat untuk tujuan edukasi dan pembelajaran Flutter.

## Kontak

Untuk pertanyaan atau dukungan, hubungi:
- Email: support@argodriver.com
- WhatsApp: +62 812 3456 7890

---

**Argo Driver App** - Solusi perhitungan tarif yang mudah dan akurat untuk driver transportasi online.