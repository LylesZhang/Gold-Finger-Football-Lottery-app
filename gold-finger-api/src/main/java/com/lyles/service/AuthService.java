package com.lyles.service;

import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lyles.repository.UcMemberRepository;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

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

        String md5_password1 = DigestUtils.md5Hex(password) + dbSalt;
        String md5_password2 = DigestUtils.md5Hex(md5_password1);

        if(md5_password2.equals(dbpassword)){
            return true;
        }
        return false;
    }

    public boolean existUser(String username){
        UcMember user;
        user = repository.findByUsername(username);

        if(user == null) return false;
        return true;
    }

    public boolean strongPassword(String password){
        if (password == null || password.length() < 8 || password.length() > 12) return false;

        boolean hasUpper = false, hasLower = false, hasDigit = false, hasSpecial = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else hasSpecial = true;
        }

        return hasUpper && hasLower && hasDigit && hasSpecial;
    }

    public UcMember save(String username, String password){
        UcMember user = new UcMember();

        user.setUsername(username);

        String salt = UUID.randomUUID().toString().replace("-", "").substring(0, 6);
        user.setSalt(salt);

        String md5_password1 = DigestUtils.md5Hex(password) + salt;
        String md5_password2 = DigestUtils.md5Hex(md5_password1);
        user.setPassword(md5_password2);

        repository.save(user);

        return user;
    }

}
