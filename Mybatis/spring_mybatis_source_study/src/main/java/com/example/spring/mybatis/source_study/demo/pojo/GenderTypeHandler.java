package com.example.spring.mybatis.source_study.demo.pojo;


import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 类型处理器
 */
public class GenderTypeHandler extends BaseTypeHandler<Gender> {

    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, Gender gender, JdbcType jdbcType) throws SQLException {
        preparedStatement.setInt(i, gender.getValue());
    }

    @Override
    public Gender getNullableResult(ResultSet resultSet, String s) throws SQLException {
        return convert(resultSet.getInt(s));
    }

    private Gender convert(int status) {
        Gender[] objs = Gender.class.getEnumConstants();
        for (Gender em : objs) {
            if (em.getValue() == status) {
                return em;
            }
        }
        return null;
    }

    @Override
    public Gender getNullableResult(ResultSet resultSet, int i) throws SQLException {
        return convert(resultSet.getInt(i));
    }

    @Override
    public Gender getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        return convert(callableStatement.getInt(i));
    }
}
