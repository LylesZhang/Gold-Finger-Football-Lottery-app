package com.lyles.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.lyles.entity.PayService;

public interface PayServiceRepository extends JpaRepository<PayService, Integer> {

    @Query(value = "SELECT * FROM maicai_u.pay_services WHERE uid = ?1 and ps_history = 0", nativeQuery = true)
    ArrayList<PayService> findServicesByUid(int uid);

    @Query(value = "SELECT * FROM maicai_u.pay_services WHERE uid = ?1 and ps_servid = ?2 and ps_history = 0", nativeQuery = true)
    ArrayList<PayService> findServiceByUidAndServid(int uid, int ps_servid);

    @Transactional
    @Modifying
    @Query(value = "UPDATE maicai_u.pay_services SET ps_history = 1 WHERE ps_id = ?1", nativeQuery = true)
    void deActivateService(int psId);
}
