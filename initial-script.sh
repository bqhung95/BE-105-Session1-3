#!/bin/bash

# 1. Cập nhật hệ thống
echo "Đang cập nhật hệ thống..."
sudo apt-get update && sudo apt-get upgrade -y

# 2. Cài đặt các gói phần mềm bắt buộc
echo "Đang cài đặt JDK 17, Git và Curl..."
sudo apt-get install -y openjdk-17-jdk git curl

# 3. Kiểm tra và tạo group quickbite nếu chưa tồn tại
if getent group quickbite > /dev/null; then
    echo "Nhóm 'quickbite' đã tồn tại."
else
    echo "Đang tạo nhóm 'quickbite'..."
    sudo groupadd quickbite
fi

# 4. Kiểm tra và tạo system user quickbite
if id "quickbite" &>/dev/null; then
    echo "User 'quickbite' đã tồn tại."
else
    echo "Đang tạo system user 'quickbite'..."
    # Cờ -r: tạo system user (không tạo thư mục home /home/quickbite)
    # Cờ -g: chỉ định group chính
    # Cờ -s: chỉ định shell (khóa đăng nhập bằng /bin/false)
    sudo useradd -r -g quickbite -s /bin/false quickbite
    echo "Tạo user 'quickbite' thành công."
fi

echo "Hoàn tất cài đặt môi trường ban đầu!"
