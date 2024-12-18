clear
printf "\n Sau khi cài đặt, mọi quyền hạn và tính năng của Termux sẽ thuộc về Dragon_Boy\n Ví dụ như bạn không thể apt install bất kì cái gì, kể cả dpkg\n\n Nếu bạn muốn quay về ban đầu, hãy cài đặt lại Termux\n\n - Bạn có muốn tiếp tục? [Y/N]\n\n"
read -p "Lựa chọn: " yesorno

if [[ $yesorno == "Y" ]] || [[ $yesorno == "y" ]]; then
    printf "\n\n"
    echo "Y" | termux-setup-storage &> /dev/null
    url="https://raw.githubusercontent.com/Kiet2007318/Dragon_boy/main"
    cpu="$(getprop ro.product.cpu.abi)"
    
    if [[ $cpu == "arm64-v8a" ]]; then
        archdeb="aarch64"
    elif [[ $cpu == "armeabi-v7a" ]] || [[ $cpu == "armeabi" ]]; then
        archdeb="arm"
        url="${url}/bin32"
    elif [[ $cpu == "x86_64" ]]; then
        archdeb="x64"
        url="${url}/binx64"
    else
        printf "\n Không hổ trợ x86 - 32bit!\n\n"
        exit 0
    fi
    
    clear
    printf "\nDownloading package....\n\n"
    curl -L --max-redirs 15 --progress-bar "https://github.com/Kiet2007318/Dragon_boy/releases/download/dragonboy-dev/dragonboy-dev_${archdeb}.deb" --output dragonboy-dev.deb || exit 0
    echo "Y" | dpkg -i --force-overwrite dragonboy-dev.deb
    curl -L --max-redirs 15 --progress-bar "${url}/install.sh" --output install.sh || exit 0
    curl -L --max-redirs 15 --progress-bar "${url}/CONF_FILE/tar.sh" --output tar.sh || exit 0
    mv ./tar.sh ~/../usr/bin/tar
    chmod 777 ./install.sh ~/../usr/bin/tar
    ./install.sh https://fb.me/Bolaphandien
fi
