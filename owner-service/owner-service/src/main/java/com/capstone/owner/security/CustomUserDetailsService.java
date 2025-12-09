package com.capstone.owner.security;

import com.capstone.owner.entity.AppOwner;
import com.capstone.owner.repository.AppOwnerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private AppOwnerRepository ownerRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AppOwner owner = ownerRepository.findByUserName(username)
                .orElseThrow(() -> new UsernameNotFoundException("Owner not found: " + username));

        return new org.springframework.security.core.userdetails.User(
                owner.getUserName(),
                owner.getPassword(),
                new ArrayList<>() // No roles for now
        );
    }
}
