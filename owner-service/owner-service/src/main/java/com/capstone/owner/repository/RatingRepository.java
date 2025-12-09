package com.capstone.owner.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.capstone.owner.entity.Rating;

import java.util.List;
import java.util.Optional;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Long> {

    List<Rating> findByAppId(Long appId);

    Optional<Rating> findByAppIdAndUserId(Long appId, Long userId);

    @Query("SELECT AVG(r.stars) FROM Rating r WHERE r.appId = :appId")
    Double getAverageRatingForApp(Long appId);

    @Query("SELECT COUNT(r) FROM Rating r WHERE r.appId = :appId")
    Long getRatingCountForApp(Long appId);
}
