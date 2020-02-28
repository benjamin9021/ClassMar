package com.naver.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadFileUtils {
   

   //utils에 들어가는 것들은 일반적으로 static으로 씀 
   public static String uploadFile(String uploadPath, MultipartFile file) throws Exception {
      
      UUID uid = UUID.randomUUID();   //UUID가 중복을 완벽히 막아주는 것은 아니다 
      String savedName = uid.toString() + "_" + file.getOriginalFilename();
      
      String savedPath = calcPath(uploadPath);
      
        System.out.println("1._ "+ uploadPath);   //servlet-context에 빈으로 작성한 업로드경로(C:\\upload)
        System.out.println("2._ "+savedPath);   //2020\\02\\25
        System.out.println("3._ "+uploadPath + savedPath);   //C:\\upload\\2020\\02\\25
        System.out.println("4._ "+savedName);
      
      File target = new File(uploadPath + savedPath, savedName);
      
      FileCopyUtils.copy(file.getBytes(), target);
      // 타겟 경로에  파일을 카피 하는역할.
      // 파일의 크기를 지정 , 타겟에는 기존에 저장되어있는 이름과 원본 파일의 경로가 담겨 있다.
      
      
      
      //파일의 확장자명만 가져오는 코드
      String type = savedName.substring(savedName.lastIndexOf(".") +1); //+1을 안해주면.JPG .TXT 이런식으로나옴
      String uploadFileName = null;
      
      if(MediaUtils.getMediaType(type) == null) {   //이미지 파일이 아닌것
         uploadFileName = makeIcon(uploadPath, savedPath, savedName);
      } else {   //이미지 파일인것
         uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
      }

      
      return uploadFileName;
   }

   
   
   
   private static String makeThumbnail(String uploadPath, String savedPath, String savedName) throws Exception {
      
      String name1 = uploadPath + savedPath + File.separator + "s_" + savedName;   //썸네일 이미지 이름
      
      //더블버퍼링 기술을 이용하여 썸네일 표현
      //더블버퍼링 : 이미지 원본을 램으로 받아온 후 다른 램에 다시 저장한 후 복사가 다 완료되면 그 파일을
      BufferedImage sourceImg = ImageIO.read(new File(uploadPath+savedPath, savedName));
      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_EXACT, 100); 
      //Method.AUTOMATIC: 자동으로 가로세로 사이즈를 지정함
      //Mode.FIT_EXACT, 100: 썸네일이미지의 가로 세로가 100으로 고정됨
      
      
      //썸네일 파일 만들기
      File f = new File(name1);
      
      //원본파일의 확장자와 썸네일의 확장자가 같게하기
      String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
      
      ImageIO.write(destImg, formatName.toUpperCase(), f);
      
      return name1.substring(uploadPath.length()).replace(File.separatorChar, '/');
   }




   private static String makeIcon(String uploadPath, String savedPath, String savedName) {

      String name = uploadPath + savedPath + File.separator + savedName;
      
      return name.substring(uploadPath.length()).replace(File.separatorChar, '/');   //uploadPath(C:\\upload) 제외-> \\2020\\02\\25\\UID_a.txt 이런식으로 남아있음)
      //uri 창에서는 역슬래시가 아니라 슬래시를 써야하기때문에 역슬래시(file.separator)를 슬래시로 변환해줌, char형이기때문에 작은따옴표로
   }




   //업로드한 파일을 날짜별로 폴더를 이용하여 정리해보기(폴더 하나에 들어갈 수 있는 파일의 용량은 제한이 있다) C:\\upload\\2020\\02\\25 이런식으로
   private static String calcPath(String uploadPath) { 
      
      Calendar cal = Calendar.getInstance();
      
      String yearPath = File.separator+cal.get(Calendar.YEAR);
      //연도 정보를 가져온다
      //파일 구분자를 넣어주기 위해  File.separator + 코드 실행    \\2020
      
      int month = (cal.get(Calendar.MONTH)+1);

      //String monthPath = yearPath + File.separator + (cal.get(Calendar.MONTH) +1); //달은 +1을 해줘야함(달을 셀때는 00월부터 시작)
      
      //폴더명에 01 02 이런식으로 들어가게 하기 위한 코드
      String monthPath = yearPath + File.separator + new DecimalFormat("00").format(month);
      //월 정보를 가져온다.
      //\\2020\\02  이렇게 된다..   Calendar 에서 month 는 1월이 아니라 0월부터 시작되기에 +1 해주어야 한다.
      //format(month) 데이터를 넣으면   DecimalFormat("00") 이러한 형태로 만들어 주겠다. 이후 yearPath + \\ 
      
      int date = cal.get(Calendar.DATE);
      String datePath = monthPath + File.separator + new DecimalFormat("00").format(date);
      //\\2020\\02\\25
      
      System.out.println(":::::::::::::::::::::::"+ datePath);

      makeDir(uploadPath, yearPath, monthPath, datePath);
      
      return datePath;
   }

   
   
   private static void makeDir(String uploadPath, String ...arr) {   //바르그스(가변형인자)사용
      
      if(new File(uploadPath + arr[arr.length-1]).exists()) {
         return;   //여기에서의 return은 폴더가 있으면 빠져나가라는 의미
      }
      for(String path : arr) {
         File f = new File(uploadPath + path);
         if(!f.exists()) {
            f.mkdir();
         }
      }
      
   }

}