package com.yuanben.hjjdatatool.common.swagger;


import org.springframework.context.annotation.Configuration;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger API文档相关配置
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig extends BaseSwaggerConfig {

    @Override
    public SwaggerProperties swaggerProperties() {
        return SwaggerProperties.builder()
                .apiBasePackage("com.yuanben.hjjdatatool")
                .title("hjj-data-tool")
                .description("hjj-data-tool项目相关接口文档")
                .contactName("湖南原本信息科技有限公司")
                .version("1.0")
                .enableSecurity(true)
                .build();
    }
}
