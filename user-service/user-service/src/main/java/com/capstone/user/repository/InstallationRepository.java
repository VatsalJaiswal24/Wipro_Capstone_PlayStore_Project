package com.capstone.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.capstone.user.entity.Installation;

import java.util.List;
import java.util.Optional;

@Repository
public interface InstallationRepository extends JpaRepository<Installation, Long> {

    boolean existsByUserIdAndAppId(Long userId, Long appId);

    List<Installation> findByUserId(Long userId);

    Optional<Installation> findByUserIdAndAppId(Long userId, Long appId);

    Long countByAppId(Long appId);
}
