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
   

   //utils�� ���� �͵��� �Ϲ������� static���� �� 
   public static String uploadFile(String uploadPath, MultipartFile file) throws Exception {
      
      UUID uid = UUID.randomUUID();   //UUID�� �ߺ��� �Ϻ��� �����ִ� ���� �ƴϴ� 
      String savedName = uid.toString() + "_" + file.getOriginalFilename();
      
      String savedPath = calcPath(uploadPath);
      
        System.out.println("1._ "+ uploadPath);   //servlet-context�� ������ �ۼ��� ���ε���(C:\\upload)
        System.out.println("2._ "+savedPath);   //2020\\02\\25
        System.out.println("3._ "+uploadPath + savedPath);   //C:\\upload\\2020\\02\\25
        System.out.println("4._ "+savedName);
      
      File target = new File(uploadPath + savedPath, savedName);
      
      FileCopyUtils.copy(file.getBytes(), target);
      // Ÿ�� ��ο�  ������ ī�� �ϴ¿���.
      // ������ ũ�⸦ ���� , Ÿ�ٿ��� ������ ����Ǿ��ִ� �̸��� ���� ������ ��ΰ� ��� �ִ�.
      
      
      
      //������ Ȯ���ڸ� �������� �ڵ�
      String type = savedName.substring(savedName.lastIndexOf(".") +1); //+1�� �����ָ�.JPG .TXT �̷������γ���
      String uploadFileName = null;
      
      if(MediaUtils.getMediaType(type) == null) {   //�̹��� ������ �ƴѰ�
         uploadFileName = makeIcon(uploadPath, savedPath, savedName);
      } else {   //�̹��� �����ΰ�
         uploadFileName = makeThumbnail(uploadPath, savedPath, savedName);
      }

      
      return uploadFileName;
   }

   
   
   
   private static String makeThumbnail(String uploadPath, String savedPath, String savedName) throws Exception {
      
      String name1 = uploadPath + savedPath + File.separator + "s_" + savedName;   //����� �̹��� �̸�
      
      //������۸� ����� �̿��Ͽ� ����� ǥ��
      //������۸� : �̹��� ������ ������ �޾ƿ� �� �ٸ� ���� �ٽ� ������ �� ���簡 �� �Ϸ�Ǹ� �� ������
      BufferedImage sourceImg = ImageIO.read(new File(uploadPath+savedPath, savedName));
      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_EXACT, 100); 
      //Method.AUTOMATIC: �ڵ����� ���μ��� ����� ������
      //Mode.FIT_EXACT, 100: ������̹����� ���� ���ΰ� 100���� ������
      
      
      //����� ���� �����
      File f = new File(name1);
      
      //���������� Ȯ���ڿ� ������� Ȯ���ڰ� �����ϱ�
      String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
      
      ImageIO.write(destImg, formatName.toUpperCase(), f);
      
      return name1.substring(uploadPath.length()).replace(File.separatorChar, '/');
   }




   private static String makeIcon(String uploadPath, String savedPath, String savedName) {

      String name = uploadPath + savedPath + File.separator + savedName;
      
      return name.substring(uploadPath.length()).replace(File.separatorChar, '/');   //uploadPath(C:\\upload) ����-> \\2020\\02\\25\\UID_a.txt �̷������� ��������)
      //uri â������ �������ð� �ƴ϶� �����ø� ����ϱ⶧���� ��������(file.separator)�� �����÷� ��ȯ����, char���̱⶧���� ��������ǥ��
   }




   //���ε��� ������ ��¥���� ������ �̿��Ͽ� �����غ���(���� �ϳ��� �� �� �ִ� ������ �뷮�� ������ �ִ�) C:\\upload\\2020\\02\\25 �̷�������
   private static String calcPath(String uploadPath) { 
      
      Calendar cal = Calendar.getInstance();
      
      String yearPath = File.separator+cal.get(Calendar.YEAR);
      //���� ������ �����´�
      //���� �����ڸ� �־��ֱ� ����  File.separator + �ڵ� ����    \\2020
      
      int month = (cal.get(Calendar.MONTH)+1);

      //String monthPath = yearPath + File.separator + (cal.get(Calendar.MONTH) +1); //���� +1�� �������(���� ������ 00������ ����)
      
      //������ 01 02 �̷������� ���� �ϱ� ���� �ڵ�
      String monthPath = yearPath + File.separator + new DecimalFormat("00").format(month);
      //�� ������ �����´�.
      //\\2020\\02  �̷��� �ȴ�..   Calendar ���� month �� 1���� �ƴ϶� 0������ ���۵Ǳ⿡ +1 ���־�� �Ѵ�.
      //format(month) �����͸� ������   DecimalFormat("00") �̷��� ���·� ����� �ְڴ�. ���� yearPath + \\ 
      
      int date = cal.get(Calendar.DATE);
      String datePath = monthPath + File.separator + new DecimalFormat("00").format(date);
      //\\2020\\02\\25
      
      System.out.println(":::::::::::::::::::::::"+ datePath);

      makeDir(uploadPath, yearPath, monthPath, datePath);
      
      return datePath;
   }

   
   
   private static void makeDir(String uploadPath, String ...arr) {   //�ٸ��׽�(����������)���
      
      if(new File(uploadPath + arr[arr.length-1]).exists()) {
         return;   //���⿡���� return�� ������ ������ ����������� �ǹ�
      }
      for(String path : arr) {
         File f = new File(uploadPath + path);
         if(!f.exists()) {
            f.mkdir();
         }
      }
      
   }

}