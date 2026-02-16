package com.lyles.dto;

import java.time.LocalDate;

public class PayServiceDetail {
    private Integer psId;
    private Integer uid;
    private Integer psServid;
    private Double psMoney;
    private LocalDate begindate;
    private LocalDate enddate;

    private String serviceName;
    private String serviceIntro;
    private Integer serviceTimeType;
    private String serviceTimeTypeName;
    private Boolean serviceEnabled;
    private Boolean serviceSmsEnabled;

    public Integer getPsId() {
        return psId;
    }

    public void setPsId(Integer psId) {
        this.psId = psId;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getPsServid() {
        return psServid;
    }

    public void setPsServid(Integer psServid) {
        this.psServid = psServid;
    }

    public Double getPsMoney() {
        return psMoney;
    }

    public void setPsMoney(Double psMoney) {
        this.psMoney = psMoney;
    }

    public LocalDate getBegindate() {
        return begindate;
    }

    public void setBegindate(LocalDate begindate) {
        this.begindate = begindate;
    }

    public LocalDate getEnddate() {
        return enddate;
    }

    public void setEnddate(LocalDate enddate) {
        this.enddate = enddate;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceIntro() {
        return serviceIntro;
    }

    public void setServiceIntro(String serviceIntro) {
        this.serviceIntro = serviceIntro;
    }

    public Integer getServiceTimeType() {
        return serviceTimeType;
    }

    public void setServiceTimeType(Integer serviceTimeType) {
        this.serviceTimeType = serviceTimeType;
    }

    public String getServiceTimeTypeName() {
        return serviceTimeTypeName;
    }

    public void setServiceTimeTypeName(String serviceTimeTypeName) {
        this.serviceTimeTypeName = serviceTimeTypeName;
    }

    public Boolean getServiceEnabled() {
        return serviceEnabled;
    }

    public void setServiceEnabled(Boolean serviceEnabled) {
        this.serviceEnabled = serviceEnabled;
    }

    public Boolean getServiceSmsEnabled() {
        return serviceSmsEnabled;
    }

    public void setServiceSmsEnabled(Boolean serviceSmsEnabled) {
        this.serviceSmsEnabled = serviceSmsEnabled;
    }
}
