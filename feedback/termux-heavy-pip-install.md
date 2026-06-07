---
name: Heavy pip install in Termux
description: How to install large Python packages (tree-sitter, scipy, etc) on Termux — use --user + extended timeout + background, but Fortran deps still block
type: feedback
---

При установке тяжёлых Python-пакетов в Termux (с большими зависимостями вроде tree-sitter парсеров, rapidfuzz, scipy) использовать:
`pip install --timeout 300 --retries 10 --user <package>` + запускать через `run_in_background: true`.

**Why:** Мобильная сеть в Termux нестабильна — pip таймаутится при скачивании с PyPI, а не в самой компиляции. `--user` нужен чтобы пакет не конфликтовал с системным site-packages Termux. Фоновый режим обязателен — обычные pip-установки тяжёлых пакетов занимают 10-30+ мин, что превышает 2-минутный лимит Bash tool.

**ВАЖНОЕ ОГРАНИЧЕНИЕ:** Эти флаги решают только сетевую проблему. Если пакет зависит от **scipy** (или другого Fortran-зависимого пакета), установка ВСЁ РАВНО упадёт — Termux не имеет gfortran/flang, а wheel'ов под `aarch64-linux-android` + свежий Python нет. Установка тяжёлых научных пакетов в Termux практически невозможна — лучше ставить на сервер 45.146.164.144 (Ubuntu x86_64) или через proot-distro Ubuntu.

**How to apply:**
- Пакеты **без** Fortran-зависимостей (graphifyy без scipy, pandas, numpy крупных ML-библиотек): `--user --timeout 300 --retries 10` + background — работает
- Пакеты **с** scipy/numpy крупными wheel-зависимостями: сразу предложить установку на сервер 45.146.164.144 или в proot-distro Ubuntu, не тратить время на повторы в Termux
- Проверить наличие gfortran: `which gfortran` — если "no", отказаться сразу
