package com.lyles.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "pay_users", catalog = "maicai_u")
@Data
public class PayUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;

    private String username;

    @Column(name = "s_money")
    private Double balance;

}
