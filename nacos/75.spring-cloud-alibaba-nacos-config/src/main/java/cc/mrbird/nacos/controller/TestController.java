package cc.mrbird.nacos.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author MrBird
 */
@RestController
@RefreshScope
public class TestController {

    @Value("${message.a}")
    private String message;
    @Value("${ext1.b}")
    private String ext1;
    @Value("${ext2.c}")
    private String ext2;

    @GetMapping("message")
    public String getMessage() {
        return this.message;
    }

    @GetMapping("multi")
    public String multiConfig() {
        System.out.printf("ffff---");
        return String.format("ext1: %s ext2: %s", ext1, ext2);
    }
}
