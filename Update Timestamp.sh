#!/bin/sh

# trap untuk menangkap signal yaitu 2 (SIGINT yaitu interruped process (Control + C)) ketika user ketik CTRL+C maka akan memanggil function touch
trap 'touch' 2

touch()
{
    # Output Message
    echo "Please input filename with extension that you want modify (type 'ALL' for all files): "
    # Input dari user
    read file_name

    # Membuat variable baru untuk menampung variable file_name yang mengandung uppercase menjadi lowercase agar menjadi variable case insensitive
    file_names=$(echo "$file_name" | tr '[:lower:]' '[:upper:]')

    # Mengecek variable yang telah diuppercase apakah user input string ALL
    if [ "$file_names" = "ALL" ]; then
        # Mencari directory sekarang dengan tipe file dengan nama apa saja kemudian menjalankan command touch
        find . -type f -exec touch {} +
        echo "All file modified" 
        exit 1

    # Jika user tidak input string ALL
    elif [ "$file_name" != " " ]; then
        # Jika Filename yang dicari ditemukan dengan menggunakan pipe "wc -l" untuk mengecek lines dari output find dibawah apakah 0 atau lebih jika 0 maka tidak ditemukan
        if [ $(find . -type f -name "${file_name}" | wc -l) != "0" ];
        then
            # Mencari directory sekarang dengan tipe file yang mengandung nama file_name dengan extension kemudian menjalankan command touch
            find . -type f -name "${file_name}" -exec touch {} +
            echo "${file_name} modified"
            exit 1
        # Jika filename yang dicari tidak ditemukan
        else
            echo "Filename doesn't exists"
            exit 1
        fi

    # Jika user input string kosong atau spasi
    else
        echo "File name empty!"
        exit 1
    fi
}

# Main
while :
do
    echo "waiting interrupt..."
    sleep 2
done