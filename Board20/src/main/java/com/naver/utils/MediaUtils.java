package com.naver.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

//�̹������� ����Ϸ� ǥ��, �̹��������� �ƴϸ� �츮�� ������ ������ ����Ϸ� ǥ��
public class MediaUtils {
   
   private static Map<String, MediaType> mediaMap;
   
   //����ƽ �ʱ�ȭ
   static {
      mediaMap = new HashMap<String, MediaType>();
      mediaMap.put("JPG", MediaType.IMAGE_JPEG);
      mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
      mediaMap.put("PNG", MediaType.IMAGE_PNG);
      mediaMap.put("GIF", MediaType.IMAGE_GIF);
      //�� �������� �̵�����Ϸ� �����Ѵٴ� �ǹ� (�̹����������� �ƴ��� Ȯ���ϱ� ���� �ʿ�)
   }
   
   public static MediaType getMediaType(String type) {
      return mediaMap.get(type.toUpperCase());   //type: JPG, PNG, GIF(Key��)
   }
   

}