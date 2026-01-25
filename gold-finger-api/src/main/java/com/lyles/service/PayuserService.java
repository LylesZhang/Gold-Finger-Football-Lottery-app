package com.lyles.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.entity.PayUser;
import com.lyles.repository.PayUserRepository;

@Service
public class PayuserService {
    @Autowired
    private PayUserRepository payUserRepository;

    public Double getBalanceByUsername(String username){
        PayUser payUser = payUserRepository.findBalancebyUsername(username);
        return payUser.getBalance();
    }
}
