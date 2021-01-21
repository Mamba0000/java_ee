package com.yuanben.hjjdatatool.common.exception;

import com.yuanben.hjjdatatool.common.api.CommonResult;
import com.yuanben.hjjdatatool.common.api.ResultCode;
import org.apache.shiro.ShiroException;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * 全局异常处理
 */
@ControllerAdvice
public class GlobalExceptionHandler {


//    // 捕捉shiro的异常
//    @ResponseStatus(HttpStatus.UNAUTHORIZED)
//    @ExceptionHandler(ShiroException.class)
//    public CommonResult handle401(ShiroException e) {
//        return CommonResult.failed(ResultCode.UNAUTHORIZED,"");
//    }

//    // 捕捉UnauthorizedException
//    @ResponseStatus(HttpStatus.UNAUTHORIZED)
//    @ExceptionHandler(UnauthorizedException.class)
//    public CommonResult handle401() {
//        return CommonResult.failed(ResultCode.UNAUTHORIZED,"");
//
//    }

//    @ResponseBody
//    @ExceptionHandler(value = ApiException.class)
//    public CommonResult handle(ApiException e) {
//        if (e.getErrorCode() != null) {
//            return CommonResult.failed(e.getErrorCode());
//        }
//        return CommonResult.failed(e.getMessage());
//    }
//
//    @ResponseBody
//    @ExceptionHandler(value = Exception.class)
//    public CommonResult handle(Exception e) {
//        return CommonResult.failed(e.getMessage());
//    }

    @ResponseBody
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public CommonResult handleValidException(MethodArgumentNotValidException e) {
        BindingResult bindingResult = e.getBindingResult();
        String message = null;
        if (bindingResult.hasErrors()) {
            FieldError fieldError = bindingResult.getFieldError();
            if (fieldError != null) {
                message = fieldError.getField() + fieldError.getDefaultMessage();
            }
        }
        return CommonResult.validateFailed(message);
    }

    @ResponseBody
    @ExceptionHandler(value = BindException.class)
    public CommonResult handleValidException(BindException e) {
        BindingResult bindingResult = e.getBindingResult();
        String message = null;
        if (bindingResult.hasErrors()) {
            FieldError fieldError = bindingResult.getFieldError();
            if (fieldError != null) {
                message = fieldError.getField() + fieldError.getDefaultMessage();
            }
        }
        return CommonResult.validateFailed(message);
    }
}
