package com.lyles.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Base64;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.io.ByteArrayOutputStream;
import javax.imageio.ImageIO;

public class RandomImageVerifyCode {
    public static final String BASE_NUMBER = "qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM0123456789";

    // public static void main(String[] args) {
    //     String resultCode = RandomImageVerifyCode.randomString(BASE_NUMBER, 4);
    //     System.out.println(resultCode);

    // }

    //生成随机字符串
    public static String randomString(String baseString, int length) {
        if (baseString == null || baseString == "") {
            return "";
        } else {
            StringBuilder sb = new StringBuilder(length);
            if (length < 1) {
                length = 1;
            }

            int baseLength = baseString.length();

            for (int i = 0; i < length; ++i) {
                int number = ThreadLocalRandom.current().nextInt(baseLength);
                sb.append(baseString.charAt(number));
            }

            return sb.toString();
        }
    }

    //生成验证码图片
    public static String produceImage(String resultCode) throws IOException {

        final int WIDTH = 105;
        final int HEIGHT = 35;
        final int COUNT = 200;
        final int LINE_WIDTH = 2;

        /**
         * 生成一张图片，将结果写入到图片
         */
        // 在内存中创建图象
        final BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文
        final Graphics2D graphics = (Graphics2D) image.getGraphics();

        // 设定背景颜色
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, WIDTH, HEIGHT);

        // 设定边框颜色
        graphics.drawRect(0, 0, WIDTH - 1, HEIGHT - 1);

        final Random random = new Random();

        // 随机产生干扰线，使图象中的认证码不易被其它程序探测到
        for (int i = 0; i < COUNT; i++) {

            final Random randomColor = new Random();
            final int r = 150 + randomColor.nextInt(50);
            final int g = 150 + randomColor.nextInt(50);
            final int b = 150 + randomColor.nextInt(50);
            graphics.setColor(new Color(r, g, b));

            // 保证画在边框之内
            final int x = random.nextInt(WIDTH - LINE_WIDTH - 1) + 1;
            final int y = random.nextInt(HEIGHT - LINE_WIDTH - 1) + 1;
            final int xl = random.nextInt(LINE_WIDTH);
            final int yl = random.nextInt(LINE_WIDTH);
            graphics.drawLine(x, y, x + xl, y + yl);
        }
        // 取随机产生的认证码
        for (int i = 0; i < resultCode.length(); i++) {
            // 设置字体颜色
            graphics.setColor(Color.BLACK);
            // 设置字体样式
            graphics.setFont(new Font("Times New Roman", Font.BOLD, 24));
            // 设置字符，字符间距，上边距
            graphics.drawString(String.valueOf(resultCode.charAt(i)), (23 * i) + 8, 26);
        }
        
        //释放资源
        graphics.dispose();

        //图片写入字节流
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "png", baos);

        return Base64.getEncoder().encodeToString(baos.toByteArray());
    }
}
