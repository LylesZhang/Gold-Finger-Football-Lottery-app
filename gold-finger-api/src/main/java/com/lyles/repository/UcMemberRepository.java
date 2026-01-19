package com.lyles.repository;

import com.lyles.entity.UcMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;;

@Repository
public interface UcMemberRepository extends JpaRepository<UcMember, Integer> {
    UcMember findByUsername(String username);
    UcMember findByEmail(String email);
}
