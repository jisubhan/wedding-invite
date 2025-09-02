#!/bin/bash

# 이미지 압축 스크립트
echo "이미지 압축을 시작합니다..."

# 백업 폴더 생성
mkdir -p original_images_backup

# 원본 이미지 백업
echo "원본 이미지를 백업합니다..."
cp *.jpeg original_images_backup/

# 각 JPEG 이미지를 압축
for file in *.jpeg; do
    if [ -f "$file" ]; then
        echo "압축 중: $file"
        
        # 원본 파일 크기 확인
        original_size=$(du -h "$file" | cut -f1)
        
        # 이미지 압축 (품질 85%, 최대 너비 1200px)
        convert "$file" -resize 1200x -quality 85 "compressed_$file"
        
        # 압축된 파일 크기 확인
        compressed_size=$(du -h "compressed_$file" | cut -f1)
        
        # 압축된 파일로 교체
        mv "compressed_$file" "$file"
        
        echo "완료: $file ($original_size → $compressed_size)"
    fi
done

echo "모든 이미지 압축이 완료되었습니다!"
echo "원본 이미지는 'original_images_backup' 폴더에 보관됩니다."
