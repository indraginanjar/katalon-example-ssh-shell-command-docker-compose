# Katalon example for using SSH shell command - Docker Compose

## Penjelasan

Ini adalah file docker-compose untuk digunakan sebagai contoh SSH server.

## Tentang dokumen ini

### Asumsi-asumsi

Dokumen ini ditulis dengan asumsi:

- Pada mesin/komputer pengguna telah terpasang aplikasi SSH client

- Pengguna telah memiliki publik key pada mesin/komputernya

- Pengguna menggunakan **[default.env](./default.env)** as **[.env](./.env)** tanpa perubahan apapun

- Pengguna tidak memiliki layanan SSH lain yang berjalan pada mesin/komputernya

### default.env

Key              | Value
-----------------|------
EXAMPLE_USERNAME | test
EXAMPLE_PASSWORD | test
EXAMPLE_SSH_PORT | 22

## Konfigurasi

Sebelum menjalankan untuk pertama kali, salin berkas **[default.env](./default.env)** ke **[.env](./.env)**

## Cara untuk membuat dan menjalankan container layanan SSH

Untuk menjalankan layanan SSH, ketik:

```bash
docker-compose up
```

atau, gunakan parameter `--build` apabila telah melakukan perubahan pada Dockerfile

```bash
docker-compose up --build
```

## Cara untuk menghentikan container layanan SSH

Untuk mematikan layanan SSH, ketik:

```bash
docker-compose down
```

## Mengakses layanan SSH

Untuk mengakses layanan SSH, ketik:

```bash
ssh <remote_user>@<remote server address> -p <remote ssh port>
```

Contoh pengaksesan jika container layanan dibuat dengan menggunakan default.env:

```bash
ssh test@localhost -p 22
```

### Mengakses SSH tanpa dimintai password

Saat membuat proses terotomatisasi, seringkali kita tidak bisa meminta pengguna untuk memasukkan password SSH. Ada dua pilihan yang umum yang bisa kita gunakan:

1. Menggunakan **sshpass**

2. Public key SSH yang tanpa password

#### Menggunakan **sshpass**

Penulisan:

```bash
sshpass -p "<remote user password>" ssh <remote_user>@<remote server address> -p <remote ssh port>
```

Contoh pengaksesan jika container layanan dibuat dengan menggunakan default.env:

```bash
sshpass -p "test" ssh test@localhost
```

Beberapa orang atau sistem menganggap penggunaan sshpass sebagai solusi yang kurang aman, sehingga ada kemungkinan ia tidak tersedia pada sistem anda.

#### Public key SSH yang tanpa password

Jika anda memiliki public key SSH yang tanpa password, anda bisa menyalinnya ke server tujuan, sehingga setelahnya perangkat anda bisa mengakses server tersebut tanpa harus memasukkan password.

> **Peringatan!**
> Karena anda tidak menggunakan password, jika mesin/komputer anda dijebol, maka server anda juga akan beresiko dijebol juga melalui mesin/komputer anda. Gunakan metode ini hanya pada lingkungan yang tertutup saja.

Jika belum ada, buat SSH key yang memiliki password kosong atau tanpa password:

```bash
ssh-keygen -t <type of key> -f <filename of the key file>
```

Salin key tanpa password tersebut ke server:

```bash
ssh-copy-id -p <remote ssh port> <remote_user>@<remote server address>
```

atau, jika anda memiliki beberapa key SSH pada mesin anda:

```bash
ssh-copy-id -i ~/.ssh/test_rsa -o 'IdentityFile ~/.ssh/test_rsa' <remote_user>@<remote server address
```

Coba uji akses tanpa password:

```bash
ssh <remote_user>@<remote server address> -p <remote ssh port>
```

##### Contoh jika container layanan dibuat dengan menggunakan default.env

Jika belum ada, buat SSH key yang memiliki password kosong atau tanpa password:

```bash
ssh-keygen -t RSA -f ~/.ssh/test_rsa
```

Salin key tanpa password tersebut ke server:

```bash
ssh-copy-id -i ~/.ssh/test_rsa test@localhost
```

atau, jika anda memiliki beberapa key SSH pada mesin anda:

```bash
ssh-copy-id -i ~/.ssh/test_rsa -o 'IdentityFile ~/.ssh/test_rsa' test@localhost
```

Coba uji akses tanpa password:

```bash
ssh test@localhost -p 22
```

or, if you have multiple SSH on your machine:

```bash
ssh -i ~/.ssh/test_rsa -p 22 test@localhost
```
