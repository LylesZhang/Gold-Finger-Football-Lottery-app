package com.lyles.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Entity
@Table(name = "pay_services")
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
    private LocalDate begindate;

    @Column(name = "enddate")
    private LocalDate enddate;
}
