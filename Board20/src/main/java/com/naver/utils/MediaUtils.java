package com.naver.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

//이미지파일 썸네일로 표시, 이미지파일이 아니면 우리가 지정한 사진이 썸네일로 표시
public class MediaUtils {
   
   private static Map<String, MediaType> mediaMap;
   
   //스태틱 초기화
   static {
      mediaMap = new HashMap<String, MediaType>();
      mediaMap.put("JPG", MediaType.IMAGE_JPEG);
      mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
      mediaMap.put("PNG", MediaType.IMAGE_PNG);
      mediaMap.put("GIF", MediaType.IMAGE_GIF);
      //이 세종류만 미디어파일로 인정한다는 의미 (이미지파일인지 아닌지 확인하기 위해 필요)
   }
   
   public static MediaType getMediaType(String type) {
      return mediaMap.get(type.toUpperCase());   //type: JPG, PNG, GIF(Key값)
   }
   

}