package com.lyles.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "pay_order", catalog = "maicai_u")
@Data
public class PayOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "order_id")
    private String orderId;

    @Column(name = "site")
    private String site;

    @Column(name = "d_id")
    private Integer dId;

    @Column(name = "c_id")
    private String cId;

    @Column(name = "f_id")
    private Integer fId;

    @Column(name = "mc_id")
    private Integer mcId;

    @Column(name = "uid")
    private Integer uid;

    @Column(name = "type")
    private Integer type;

    @Column(name = "bm")
    private Integer bm;

    @Column(name = "money")
    private BigDecimal money;

    @Column(name = "balance")
    private BigDecimal balance;

    @Column(name = "cb")
    private Integer cb;

    @Column(name = "note")
    private String note;

    @Column(name = "title")
    private String title;

    @Column(name = "time")
    private LocalDateTime time;

    @Column(name = "del")
    private Integer del;
}
