package com.lyles.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.lyles.config.PayConfig;
import com.lyles.entity.PayService;
import com.lyles.repository.PayUserRepository;
import com.lyles.repository.PayServiceRepository;
import java.time.LocalDate;
import java.util.List;

@Service
public class SubscribeService {

    @Autowired
    PayuserService payuserService;

    @Autowired
    PayUserRepository payUserRepository;

    @Autowired
    PayServiceRepository payServiceRepository;

    public List<PayConfig.ServiceGroupConfig> findAllServiceGroups(){
        return PayConfig.IOSAPP_GROUPS;
    }

    @Transactional
    public PayService subscribeService(int uid, int ps_servid, int timeType){
        Double balance = payuserService.getBalanceByUid(uid);
        PayService activeService = null;

        try{
            activeService = payuserService.getActiveServiceByUidAndServid(uid, ps_servid);
        } catch (RuntimeException e){
            throw new RuntimeException("查询服务异常: " + e.getMessage());
        }

        // 从 IOSAPP_GROUPS 配置中查找对应套餐的价格
        double cost = PayConfig.IOSAPP_GROUPS.stream()
            .flatMap(g -> g.getPlans().stream())
            .filter(p -> p.getServId() == ps_servid && p.getTimeType() == timeType)
            .findFirst()
            .orElseThrow(() -> new RuntimeException("找不到对应套餐"))
            .getMoney();

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
                switch (timeType) {
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
                switch (timeType) {
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
            newService.setPsUser("");
            newService.setPsTimes(0);
            newService.setPsSms(0);
            newService.setPsHistory(0);
            newService.setPsMod(0);
            newService.setPsOperator("");
            newService.setPsLog("");
            newService.setIsDel(0);
            payServiceRepository.save(newService);
            //4.扣款
            payUserRepository.reduceBalance(uid, cost);

            return newService;
        }
    }
}
