package com.example.spring.mybatis.source_study.demo.pojo;

public enum Gender {
    MAN("男性", 1), MALE("女性", 0);


    private String label;

    private Integer value;

    Gender(String label, Integer value) {
        this.label = label;
        this.value = value;
    }

    public Integer getValue() {
        return value;
    }

    public String getLabel() {
        return label;
    }


}

