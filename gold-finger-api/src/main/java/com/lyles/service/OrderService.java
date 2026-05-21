package com.lyles.service;

import com.lyles.entity.PayOrder;
import com.lyles.repository.PayOrderRepository;
import com.lyles.repository.PayUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

@Service
public class OrderService {

    @Autowired
    private PayOrderRepository payOrderRepository;

    @Autowired
    private PayUserRepository payUserRepository;

    @Autowired
    private PayuserService payuserService;

    public List<Integer> getPurchasedFids(int uid) {
        return payOrderRepository.findFidsByUid(uid);
    }

    @Transactional
    public void buyArticle(int uid, int fid, int money, int dId, String title) {
        Double balance = payuserService.getBalanceByUid(uid);
        if (balance == null) throw new RuntimeException("用户不存在");
        if (balance < money) throw new RuntimeException("余额不足，当前余额：" + String.format("%.2f", balance) + " 元");
        if (payOrderRepository.countByUidAndFid(uid, fid) > 0) throw new RuntimeException("该文章已购买");

        String orderId = System.currentTimeMillis() + String.format("%03d", new Random().nextInt(1000));

        PayOrder order = new PayOrder();
        order.setOrderId(orderId);
        order.setSite("APP");
        order.setDId(dId);
        order.setCId("0");
        order.setFId(fid);
        order.setMcId(0);
        order.setUid(uid);
        order.setType(18);
        order.setBm(0);
        order.setMoney(BigDecimal.valueOf(money));
        order.setBalance(BigDecimal.valueOf(balance - money));
        order.setCb(0);
        order.setNote("USERS_HAVE_SERVER_OUT_" + money);
        order.setTitle(title);
        order.setTime(LocalDateTime.now());
        order.setDel(0);

        payOrderRepository.save(order);
        payUserRepository.reduceBalance(uid, money);
    }
}
