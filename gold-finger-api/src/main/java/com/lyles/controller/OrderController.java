package com.lyles.controller;

import com.lyles.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/purchased")
    public ResponseEntity<?> getPurchased(@RequestParam int uid) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Integer> fids = orderService.getPurchasedFids(uid);
            response.put("success", true);
            response.put("fids", fids);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(400).body(response);
        }
    }

    @PostMapping("/buy")
    public ResponseEntity<?> buyArticle(
            @RequestParam int uid,
            @RequestParam int fid,
            @RequestParam int money,
            @RequestParam(defaultValue = "0") int dId,
            @RequestParam(defaultValue = "") String title) {
        Map<String, Object> response = new HashMap<>();
        try {
            orderService.buyArticle(uid, fid, money, dId, title);
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(400).body(response);
        }
    }
}
