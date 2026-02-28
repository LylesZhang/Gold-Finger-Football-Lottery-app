package com.lyles.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.lyles.entity.PayUser;

public interface PayUserRepository extends JpaRepository<PayUser, Integer> {
    @Query(value = "SELECT * FROM maicai_u.pay_users WHERE username = ?1", nativeQuery = true)
    PayUser findBalancebyUsername(String username);

    @Query(value = "SELECT * FROM maicai_u.pay_users WHERE uid = ?1", nativeQuery = true)
    PayUser findBalancebyUid(int uid);

    @Transactional
    @Modifying
    @Query(value = "UPDATE maicai_u.pay_users SET s_money = s_money - ?2 WHERE uid = ?1", nativeQuery = true)
    void reduceBalance(int uid, double cost);

}
