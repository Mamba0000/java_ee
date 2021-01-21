package com.yuanben.hjjdatatool.common.util;
import com.alibaba.fastjson.JSONObject;

public class JsonConvertUtil {

    private JsonConvertUtil() {}

    /**
     * JSON 转 Object
     */
    public static <T> T jsonToObject(String pojo, Class<T> clazz) {
        return JSONObject.parseObject(pojo, clazz);
    }

    /**
     * Object 转 JSON
     */
    public static <T> String objectToJson(T t){
        return JSONObject.toJSONString(t);
    }
}