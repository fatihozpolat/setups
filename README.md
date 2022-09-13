# setups

İçinde çeşitli bash kodları yayınlamayı düşündüğüm repo.

## Vestacp
İlk olarak temiz centos 7 sunucuya php, vestacp, nodejs16, nano, git, unzip, filemanager, composer kurulumu.

```bash
wget -O vesta-setup.sh https://raw.githubusercontent.com/fatihozpolat/setups/main/vesta-centos.sh
```

|Parametre| Açıklama   |
|---------|------------|
|-h       | Host adı   |
|-e       | e posta    |
|-p       | Şifreniz   |
|-v       | php sürümü |

```bash
sh vesta-setup.sh -h srv1.sunucuadi.com -e email@email.com -p sifreniz -v 81
```

