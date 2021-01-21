package com.example.demo.common.entity;

import org.springframework.util.StringUtils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 * AES算法进行加密
 *
 * @author CodeGeek
 * @create 2018-01-23 上午11:00
 **/
public class EncryptUtils {

    /**
     * 密钥
     */
    private static final String KEY = "1234567812345678";

    /**
     * 算法
     */
    private static final String ALGORITHMSTR = "AES/CBC/PKCS5Padding";

    private static final String IV_STRING = "16-Bytes--String";


    public static void main(String[] args) throws Exception {
        String content = "123456789";
        System.out.println("加密前：" + content);

        System.out.println("加密密钥和解密密钥：" + KEY);

        String encrypt = aesEncrypt(content, KEY);
        System.out.println("加密后：" + encrypt);

//        encrypt = "RnDN1elipKDMDQHriLi+4g==";

        String decrypt = aesDecrypt(encrypt, KEY);

        System.out.printf(">>"+getKeyFromUUID("2d10e48f-fbf2-49d5-b1cf-3b74eb4b1d24")+"<<");

        System.out.println("解密后：" + decrypt);
    }

    public static String getKeyFromUUID(String uuid) {
        return uuid.substring(4, 20);
    }

    /**
     * base 64 encode
     *
     * @param bytes 待编码的byte[]
     * @return 编码后的base 64 code
     */
    private static String base64Encode(byte[] bytes) {
        return Base64.encode(bytes);
    }

    /**
     * base 64 decode
     *
     * @param base64Code 待解码的base 64 code
     * @return 解码后的byte[]
     * @throws Exception 抛出异常
     */
    private static byte[] base64Decode(String base64Code) throws Exception {
        return StringUtils.isEmpty(base64Code) ? null : Base64.decode(base64Code);
    }


    /**
     * AES加密
     *
     * @param content    待加密的内容
     * @param encryptKey 加密密钥
     * @return 加密后的byte[]
     */
    private static byte[] aesEncryptToBytes(String content, String encryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
        byte[] initParam = IV_STRING.getBytes();

        IvParameterSpec ivParameterSpec = new IvParameterSpec(initParam);

        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(encryptKey.getBytes(), "AES"),ivParameterSpec);

        return cipher.doFinal(content.getBytes("utf-8"));
    }


    /**
     * AES加密为base 64 code
     *
     * @param content    待加密的内容
     * @param encryptKey 加密密钥
     * @return 加密后的base 64 code
     */
    public static String aesEncrypt(String content, String encryptKey) throws Exception {
        return base64Encode(aesEncryptToBytes(content, encryptKey));
    }

    /**
     * AES解密
     *
     * @param encryptBytes 待解密的byte[]
     * @param decryptKey   解密密钥
     * @return 解密后的String
     */
    private static String aesDecryptByBytes(byte[] encryptBytes, String decryptKey) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);

        Cipher cipher = Cipher.getInstance(ALGORITHMSTR);
        byte[] initParam = IV_STRING.getBytes();

        IvParameterSpec ivParameterSpec = new IvParameterSpec(initParam);
        cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(decryptKey.getBytes(), "AES"),ivParameterSpec);
        byte[] decryptBytes = cipher.doFinal(encryptBytes);

        return new String(decryptBytes);
    }


    /**
     * 将base 64 code AES解密
     *
     * @param encryptStr 待解密的base 64 code
     * @param decryptKey 解密密钥
     * @return 解密后的string
     */
    public static String aesDecrypt(String encryptStr, String decryptKey) throws Exception {
        return StringUtils.isEmpty(encryptStr) ? null : aesDecryptByBytes(base64Decode(encryptStr), decryptKey);
    }

}