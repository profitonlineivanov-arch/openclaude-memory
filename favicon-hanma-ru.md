---
name: Hanma.ru Favicon Setup
description: Создан HTML-код для фавиконов hanma.ru
type: project
originSessionId: 9864dd2a-01a6-496d-8145-6ee158f78fd7
---
## Задача выполнена: 2026-04-17

**Проект:** hanma.ru (WordPress)
**Исходные файлы:** C:\Users\admin\Downloads\favicon_package_v0.16\

**Подготовленные файлы:**
- favicon.ico (15086 bytes)
- favicon-16x16.png
- favicon-32x32.png
- apple-touch-icon.png (1631 bytes)
- android-chrome-192x192.png
- android-chrome-512x512.png
- mstile-150x150.png
- safari-pinned-tab.svg
- site.webmanifest
- browserconfig.xml

**HTML-код для WordPress (header.php перед </head>):**
```html
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/favicon.ico" sizes="any">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">

<!-- Apple Touch Icon -->
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">

<!-- Android Chrome -->
<link rel="manifest" href="/site.webmanifest">
<meta name="theme-color" content="#389283">

<!-- Windows Tile -->
<meta name="msapplication-TileImage" content="/mstile-150x150.png">
<meta name="msapplication-TileColor" content="#da532c">

<!-- Safari Pinned Tab -->
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#389283">
```

**Путь на сервере:** корень WordPress (public_html/)