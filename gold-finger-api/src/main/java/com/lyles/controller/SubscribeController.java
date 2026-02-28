package com.lyles.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lyles.service.SubscribeService;
import com.lyles.entity.PayService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/api/service")
public class SubscribeController {

    @Autowired
    private SubscribeService subscribeService;

    @GetMapping("/groups")
    public ResponseEntity<?> getServiceGroups() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("groups", subscribeService.findAllServiceGroups());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/subscribe")
    public ResponseEntity<?> subscribe(
            @RequestParam int uid,
            @RequestParam int ps_servid,
            @RequestParam int timeType) {

        Map<String, Object> response = new HashMap<>();

        try {
            PayService newService = subscribeService.subscribeService(uid, ps_servid, timeType);
            response.put("success", true);
            response.put("service", newService);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(400).body(response);
        }
    }
}
