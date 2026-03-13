package com.kaushika.userService.authentication.repository;

import com.kaushika.userService.authentication.models.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TokenRepository extends JpaRepository<Token, Long> {


    @Query("SELECT t FROM Token t WHERE t.user.id = :userId ORDER BY t.createdAt DESC")
    Token findTopPinByUserIdOrderByCreatedTimeDesc(@Param("userId") Long userId);

    Token findTopByUserIdOrderByCreatedAtDesc(Long userId);


}
