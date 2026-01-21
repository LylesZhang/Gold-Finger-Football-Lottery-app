package com.lyles.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "uc_members")
@Data
public class UcMember{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer uid;
    private String username;
    private String password;
    private String email;
    private String salt;
}