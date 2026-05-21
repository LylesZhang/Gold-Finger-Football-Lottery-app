package com.lyles.repository;

import com.lyles.entity.PayOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PayOrderRepository extends JpaRepository<PayOrder, Integer> {

    @Query(value = "SELECT f_id FROM maicai_u.pay_order WHERE uid = ?1 AND f_id > 0 AND del = 0", nativeQuery = true)
    List<Integer> findFidsByUid(int uid);

    @Query(value = "SELECT COUNT(*) FROM maicai_u.pay_order WHERE uid = ?1 AND f_id = ?2 AND del = 0", nativeQuery = true)
    int countByUidAndFid(int uid, int fid);
}
