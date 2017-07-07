package com.suteam.html.common.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;

import javax.imageio.ImageIO;

public class FontImageUtil {
	public static void main(String[] args) throws Exception {
		Font font = loadFont( "C:\\Users\\zsyun\\Desktop\\方正吕建德字体简体.TTF", 50f);// 调用
		String str ="企业税收流失风险大数据智能评估系统";
		createImage(str, font, new File("C:\\Users\\zsyun\\Desktop\\a2.png"), str.length()*50, 50);
	}

	
	
	// 根据str,font的样式以及输出文件目录
	public static void createImage(String str, Font font, File outFile, Integer width, Integer height)
			throws Exception {
		// 创建图片
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
		// 获取Graphics2D
		Graphics2D g = image.createGraphics();
		image = g.getDeviceConfiguration().createCompatibleImage(width, height, Transparency.TRANSLUCENT);
		g.dispose();
		g = image.createGraphics();
		// Graphics g = image.getGraphics();
		g.setClip(0, 0, width, height);
		
		// g.setColor(new Color(0,36,193,0));
		//g.fillRect(0, 0, width, height);// 先用黑色填充整张图片,也就是背景
		g.setColor(new Color(255, 255, 255));// 在换成黑色
		g.setFont(font);// 设置画笔字体
		/** 用于获得垂直居中y */
		Rectangle clip = g.getClipBounds();
		FontMetrics fm = g.getFontMetrics(font);
		int ascent = fm.getAscent();
		int descent = fm.getDescent();
		int y = (clip.height - (ascent + descent)) / 2 + ascent+3;
		g.drawString(str, 0,y);// 画出字符串
		g.dispose();
		ImageIO.write(image, "png", outFile);// 输出png图片
	}
	public static Font loadFont(String fontFileName, float fontSize) // 第一个参数是外部字体名，第二个是字体大小
	{
		try {
			File file = new File(fontFileName);
			FileInputStream aixing = new FileInputStream(file);
			Font dynamicFont = Font.createFont(Font.TRUETYPE_FONT, aixing);
			Font dynamicFontPt = dynamicFont.deriveFont(fontSize);
			aixing.close();
			return dynamicFontPt;
		} catch (Exception e)// 异常处理
		{
			e.printStackTrace();
			return new java.awt.Font("宋体", Font.PLAIN, 14);
		}
	}



	public static void createImageWordS(String system_logo_new,String path,String ttf ,float fontSize) {
		try {
			
			Font font = loadFont( ttf, fontSize);// 调用
				createImage(system_logo_new, font, new File(path), system_logo_new.length()*100,100);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}