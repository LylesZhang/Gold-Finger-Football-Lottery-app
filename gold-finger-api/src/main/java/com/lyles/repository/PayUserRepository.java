package com.lyles.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.lyles.entity.PayUser;

public interface PayUserRepository extends JpaRepository<PayUser, Integer> {
    @Query(value = "SELECT * FROM maicai_u.pay_users WHERE username = ?1", nativeQuery = true)
    PayUser findBalancebyUsername(String username);
}
