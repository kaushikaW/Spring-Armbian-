package com.kaushika.userService.authentication.security.initializers;


import com.kaushika.userService.authentication.models.ERole;
import com.kaushika.userService.authentication.models.Role;
import com.kaushika.userService.authentication.models.User;
import com.kaushika.userService.authentication.repository.RoleRepository;
import com.kaushika.userService.authentication.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

@Component
public class AdminInitializer implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public AdminInitializer(RoleRepository roleRepository,
                            UserRepository userRepository,
                            PasswordEncoder passwordEncoder) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) throws Exception {

        // ----- 1. Insert default roles if not exist -----
        if (roleRepository.count() == 0) {
            Role userRole = new Role();
            userRole.setName(ERole.ROLE_USER);
            Role modRole = new Role();
            modRole.setName(ERole.ROLE_MODERATOR);
            Role adminRole = new Role();
            adminRole.setName(ERole.ROLE_ADMIN);

            roleRepository.save(userRole);
            roleRepository.save(modRole);
            roleRepository.save(adminRole);

            System.out.println("Default roles inserted!");
        }

        // ----- 2. Create first admin user if not exist -----
        if (!userRepository.existsByUsername("admin")) {

            User admin = new User();
            admin.setUsername("admin");
            admin.setEmail("admin@example.com"); // optional
            admin.setPassword(passwordEncoder.encode("admin123")); // hash the password

            // Assign ROLE_ADMIN
            Role adminRole = roleRepository.findByName(ERole.ROLE_ADMIN)
                                           .orElseThrow(() -> new RuntimeException("Admin role not found"));

            Set<Role> roles = new HashSet<>();
            roles.add(adminRole);
            admin.setRoles(roles);

            userRepository.save(admin);

            System.out.println("Default admin user created!");
            System.out.println("username: admin");
            System.out.println("password: admin123");


        }
    }
}
