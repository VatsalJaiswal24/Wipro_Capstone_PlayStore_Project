package com.capstone.owner.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.capstone.owner.entity.AppOwner;
import java.util.Optional;

@Repository
public interface AppOwnerRepository extends JpaRepository<AppOwner, Long> {

    Optional<AppOwner> findByUserName(String userName);

    boolean existsByUserName(String userName);

    boolean existsByEmail(String email);
}