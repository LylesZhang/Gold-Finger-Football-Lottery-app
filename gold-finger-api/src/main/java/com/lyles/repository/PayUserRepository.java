package com.lyles.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.lyles.entity.PayUser;
import com.lyles.entity.PayService;

public interface PayUserRepository extends JpaRepository<PayUser, Integer> {
    @Query(value = "SELECT * FROM maicai_u.pay_users WHERE username = ?1", nativeQuery = true)
    PayUser findBalancebyUsername(String username);

    @Query(value = "SELECT * FROM maicai_u.pay_services WHERE uid  = ?1 and ps_history = 0", nativeQuery = true)
    ArrayList<PayService> findServicesByUid(int uid);
}
