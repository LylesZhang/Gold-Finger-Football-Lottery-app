package com.lyles.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.entity.PayUser;
import com.lyles.entity.PayService;
import com.lyles.config.PayConfig;
import com.lyles.dto.PayServiceDetail;
import com.lyles.repository.PayUserRepository;

@Service
public class PayuserService {

    @Autowired
    private PayUserRepository payUserRepository;

    public Double getBalanceByUsername(String username){
        PayUser payUser = payUserRepository.findBalancebyUsername(username);
        if(payUser != null){
            return payUser.getBalance();
        }
        return null;
    }

    public ArrayList<PayServiceDetail> getServicesByUid(int uid){
        ArrayList<PayService> serviceList = payUserRepository.findServicesByUid(uid);
        ArrayList<PayServiceDetail> detailedList = new ArrayList<>();

        if (serviceList != null) {
            for (PayService item : serviceList) {

                PayServiceDetail detail = new PayServiceDetail();

                detail.setPsId(item.getPsId());
                detail.setUid(item.getUid());
                detail.setPsServid(item.getPsServid());
                detail.setPsMoney(item.getPsMoney());
                detail.setBegindate(item.getBegindate());
                detail.setEnddate(item.getEnddate());

                // 从 PayConfig 获取服务详情
                PayConfig.ServiceConfig config = PayConfig.SERVICES.get(item.getPsServid());

                if (config != null) {
                    detail.setServiceName(config.getName());
                    detail.setServiceIntro(config.getIntro());
                    detail.setServiceTimeType(config.getTimeType());
                    detail.setServiceTimeTypeName(PayConfig.SERVICE_TIME_TYPES.get(config.getTimeType()));
                    detail.setServiceEnabled(config.getEnabled());
                    detail.setServiceSmsEnabled(config.getSmsEnabled());
                }

                detailedList.add(detail);
            }

            if(detailedList != null){
                return detailedList;
            }
            return null;
        }
        return null;
    }
}
