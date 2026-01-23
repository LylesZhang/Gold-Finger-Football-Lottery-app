package com.lyles.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lyles.entity.UcMember;
import com.lyles.service.AuthService;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService service;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String idString, @RequestParam String password){

        UcMember user = service.login(idString, password);

        Map<String, Object> response = new HashMap<>();

        if(user != null){
            response.put("success", true);
            response.put("uid", user.getUid());
            response.put("username", user.getUsername());
            response.put("email", user.getEmail());
            return ResponseEntity.ok(response);
        }
        else{
            response.put("success", false);
            response.put("message", "用户名或密码错误");
            return ResponseEntity.status(401).body(response);
        }
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestParam String username, @RequestParam String password){

    Map<String, Object> response = new HashMap<>();

        if(service.existUser(username)){
            response.put("success", false);
            response.put("message", "用户名已存在！");
            return ResponseEntity.status(409).body(response);
        }

        if(!service.strongPassword(password)){
            response.put("success", false);
            response.put("message", "密码长度需在8-12位，且饱含大写字母，小写字母，数字以及特殊符号");
            return ResponseEntity.status(400).body(response);
        }

        UcMember user = service.save(username, password);

        response.put("success", true);
        response.put("uid", user.getUid());
        response.put("username", user.getUsername());
        return ResponseEntity.ok(response);
    }
    
}
