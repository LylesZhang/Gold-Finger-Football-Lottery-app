package com.lyles.service;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.repository.UcMemberRepository;
import com.lyles.entity.UcMember;

@Service
public class AuthService {

    @Autowired
    private UcMemberRepository repository;

    public UcMember login(String idString, String password){
        UcMember user;

        // 假设是用户名
        user = repository.findByUsername(idString);

        if(user != null){
            if(checkPassword(user, password)){
                return user;
            }
        }

        //假设是邮箱
        user = repository.findByEmail(idString);

        if(user != null){
            if(checkPassword(user, password)){
                return user;
            }
        }

        //都找不到返回null
        return null;
    }

    public boolean checkPassword(UcMember user, String password){
        String dbpassword = user.getPassword();
        String dbSalt = user.getSalt();

        String md5_password = DigestUtils.md5Hex(password + dbSalt);

        if(md5_password.equals(dbpassword)){
            return true;
        }
        return false;
    }
}
