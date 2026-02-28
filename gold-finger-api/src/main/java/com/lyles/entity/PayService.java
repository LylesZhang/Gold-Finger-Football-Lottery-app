package com.lyles.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "pay_services", catalog = "maicai_u")
@Data
public class PayService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ps_id")
    private Integer psId;

    @Column(name = "uid")
    private Integer uid;

    @Column(name = "ps_servid")
    private Integer psServid;

    @Column(name = "ps_money")
    private Double psMoney;

    @Column(name = "begindate")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate begindate;

    @Column(name = "enddate")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate enddate;

    @Column(name = "ps_user")
    private String psUser;

    @Column(name = "ps_times")
    private Integer psTimes;

    @Column(name = "ps_sms")
    private Integer psSms;

    @Column(name = "ps_history")
    private Integer psHistory;

    @Column(name = "ps_mod")
    private Integer psMod;

    @Column(name = "ps_operator")
    private String psOperator;

    @Column(name = "ps_log")
    private String psLog;

    @Column(name = "is_del")
    private Integer isDel;
}
