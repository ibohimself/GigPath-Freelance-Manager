# GigPath - Freelancer Finans ve Portföy Yönetimi

**Geliştirici:** İbrahim Karakaş (Öğrenci No: 202442501041)

## Proje Hakkında
GigPath, Upwork, Bionluk ve Fiverr gibi platformlarda çalışan serbest zamanlı profesyonellerin (freelancer) proje süreçlerini ve gelirlerini tek bir ekrandan yönetebilmeleri amacıyla geliştirilmiş bir mobil asistandır. 

Bu proje, Mobil Programlama dersi final teslimi kapsamında "Agile" süreçlerine uygun olarak Sprint aşamalarıyla geliştirilmiştir.

## Teknik Detaylar (Minimum Çalışan Ürün - MVP)
- **Platform:** Flutter (Cross-Platform)
- **Mimari:** Temel UI/Business Logic ayrımı (Clean Code prensipleri doğrultusunda)
- **Veri Yönetimi:** `sqflite` paketi kullanılarak Cihaz İçi Yerel Veritabanı (SQLite) entegrasyonu sağlanmıştır. Veriler kalıcı olarak cihazda tutulmaktadır.
- **Versiyon Kontrolü:** Git ve GitHub

## Özellikler (Mevcut Durum)
- [x] Yeni freelance proje (Gig) ekleme (Proje adı ve Bütçe)
- [x] Eklenen projelerin SQLite veritabanına kaydedilmesi
- [x] Proje listesinin ve toplam kazancın dinamik olarak ana ekranda listelenmesi

## Kurulum
Projeyi yerel ortamınızda çalıştırmak için:
1. Depoyu bilgisayarınıza klonlayın: `git clone <repo_url>`
2. Gerekli paketleri yükleyin: `flutter pub get`
3. Uygulamayı başlatın: `flutter run`
