package com.lyles.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lyles.entity.PayUser;
import com.lyles.entity.PayService;
import com.lyles.service.PayuserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api/payuser")
public class PayUserController {

    @Autowired
    private PayuserService payuserService;

    @GetMapping("/balance")
    public ResponseEntity<?> getBalance(@RequestParam String username) {

        Map<String, Object> response = new HashMap<>();

        Double balance = payuserService.getBalanceByUsername(username);
        if(balance != null){
            response.put("success", true);
            response.put("username",username);
            response.put("balance", balance);
            return ResponseEntity.ok(response);
        }
        else{
            response.put("success", false);
            response.put("message", "用户不存在");
            return ResponseEntity.status(404).body(response);
        }
    }

    @GetMapping("/payservice")
    public ResponseEntity<?> getService(@RequestParam int uid) {

        Map<String, Object> response = new HashMap<>();

        ArrayList<PayService> serviceList = payuserService.getServicesByUid(uid);
        if(serviceList != null){
            response.put("success", true);
            response.put("uid", uid);
            response.put("servicelist", serviceList);
            return ResponseEntity.ok(response);
        }
        else{
            response.put("success", false);
            response.put("message", "服务不存在");
            return ResponseEntity.status(404).body(response);
        }
    }
    
    

}
