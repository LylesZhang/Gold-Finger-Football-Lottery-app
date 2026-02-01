package com.lyles.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.entity.PayUser;
import com.lyles.entity.PayService;
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

    public ArrayList<PayService> getServicesByUid(int uid){
        ArrayList<PayService> serviceList = payUserRepository.findServicesByUid(uid);
        if(serviceList != null){
            return serviceList;
        }
        return null;
    }
}
