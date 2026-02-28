package com.lyles.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lyles.config.PayConfig;
import com.lyles.entity.PayService;
import com.lyles.repository.PayUserRepository;
import com.lyles.repository.PayServiceRepository;
import java.time.LocalDate;
import java.util.ArrayList;

@Service
public class SubscribeService {

    @Autowired
    PayuserService payuserService;

    @Autowired
    PayUserRepository payUserRepository;

    @Autowired
    PayServiceRepository payServiceRepository;

    public ArrayList<PayConfig.ServiceConfig> findAllAvailableService(){
        ArrayList<PayConfig.ServiceConfig> AvailableServiceList = new ArrayList<>();
        for(Integer i: PayConfig.IOSAPP){
            PayConfig.ServiceConfig service = PayConfig.SERVICES.get(i);
            if(service != null && Boolean.TRUE.equals(service.getEnabled())){
                AvailableServiceList.add(service);
            }
        }

        return AvailableServiceList;
    }

    public PayService subscribeService(int uid, int ps_servid){
        Double balance = payuserService.getBalanceByUid(uid);
        PayService activeService = null;

        try{
            activeService = payuserService.getActiveServiceByUidAndServid(uid, ps_servid);
        } catch (RuntimeException e){
            throw new RuntimeException("查询服务异常: " + e.getMessage());
        }

        double cost = PayConfig.SERVICES.get(ps_servid).getMoney();

        if(balance == null){
            throw new RuntimeException("用户不存在！");
        }
        if(balance < cost){
            throw new RuntimeException("用户余额不足！"); 
        }
        else{
            //2.计算日期插入新的pay_service
            LocalDate beginDate, endDate;
            if(activeService == null || activeService.getEnddate().isBefore(LocalDate.now())){
                beginDate = LocalDate.now();
                switch (PayConfig.SERVICES.get(ps_servid).getTimeType()) {
                    case 1 -> endDate = beginDate.plusDays(1);       // 天
                    case 2 -> endDate = beginDate.plusMonths(1);     // 月
                    case 3 -> endDate = beginDate.plusYears(1);      // 年
                    case 4 -> endDate = beginDate.plusMonths(3);     // 一季度
                    case 5 -> endDate = beginDate.plusMonths(6);     // 半年
                    default -> throw new RuntimeException("未知计费周期");
                }
            }
            else{
                //1.复制新的pay_service,将旧的service改掉
                payServiceRepository.deActivateService(activeService.getPsId());
                beginDate = activeService.getBegindate();
                endDate = activeService.getEnddate();
                switch (PayConfig.SERVICES.get(ps_servid).getTimeType()) {
                    case 1 -> endDate = endDate.plusDays(1);       // 天
                    case 2 -> endDate = endDate.plusMonths(1);     // 月
                    case 3 -> endDate = endDate.plusYears(1);      // 年
                    case 4 -> endDate = endDate.plusMonths(3);     // 一季度
                    case 5 -> endDate = endDate.plusMonths(6);     // 半年
                    default -> throw new RuntimeException("未知计费周期");
                }
            }
            //3.插入新的服务记录
            PayService newService = new PayService();
            newService.setUid(uid);
            newService.setPsServid(ps_servid);
            newService.setPsMoney(cost);
            newService.setBegindate(beginDate);
            newService.setEnddate(endDate);
            payServiceRepository.save(newService);
            //4.扣款
            payUserRepository.reduceBalance(uid, cost);

            return newService;
        }
    }
}
