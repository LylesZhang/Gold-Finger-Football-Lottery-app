package com.lyles.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.entity.PayUser;
import com.lyles.entity.PayService;
import com.lyles.config.PayConfig;
import com.lyles.dto.PayServiceDetail;
import com.lyles.repository.PayUserRepository;
import com.lyles.repository.PayServiceRepository;

@Service
public class PayuserService {

    @Autowired
    private PayUserRepository payUserRepository;

    @Autowired
    private PayServiceRepository payServiceRepository;

    public Double getBalanceByUsername(String username){
        PayUser payUser = payUserRepository.findBalancebyUsername(username);
        if(payUser != null){
            return payUser.getBalance();
        }
        return null;
    }

    public Double getBalanceByUid(int uid){
        PayUser payUser = payUserRepository.findBalancebyUid(uid);
        if(payUser != null){
            return payUser.getBalance();
        }
        return null;
    }

    public ArrayList<PayServiceDetail> getServicesByUid(int uid){
        ArrayList<PayService> serviceList = payServiceRepository.findServicesByUid(uid);
        ArrayList<PayServiceDetail> detailedList = new ArrayList<>();

        if (serviceList != null) {
            for (PayService item : serviceList) {
                //只需要显示金手指APP有的服务
                if(PayConfig.IOSAPP.contains(item.getPsServid())){
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
            }

            return detailedList;
        }
        return null;
    }

    public PayService getActiveServiceByUidAndServid(int uid, int ps_servid){
        ArrayList<PayService> serviceList = payServiceRepository.findServiceByUidAndServid(uid, ps_servid);
        if(serviceList.size() > 1){
            throw new RuntimeException("uid=" + uid + " 存在多条有效服务记录");
        }
        else if(serviceList.size() == 0){
            return null;
        }
        else{
            PayService activeService = serviceList.get(0);
            return activeService;
        }
    }
}
