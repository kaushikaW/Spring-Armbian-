package com.kaushika.userService.authentication.repository;

import java.util.Optional;

import com.kaushika.userService.authentication.models.ERole;
import com.kaushika.userService.authentication.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
  Optional<Role> findByName(ERole name);
}
