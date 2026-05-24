package com.lyles.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lyles.dto.PayServiceDetail;
import com.lyles.service.PayuserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api/payuser")
public class PayUserController {

    @Autowired
    private PayuserService payuserService;

    @GetMapping("/payservice")
    public ResponseEntity<?> getService(@RequestParam int uid) {

        Map<String, Object> response = new HashMap<>();

        ArrayList<PayServiceDetail> serviceList = payuserService.getServicesByUid(uid);
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
