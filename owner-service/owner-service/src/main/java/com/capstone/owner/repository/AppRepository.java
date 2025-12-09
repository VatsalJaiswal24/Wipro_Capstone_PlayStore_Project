package com.capstone.owner.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.capstone.owner.entity.AppDetails;
import java.util.List;

@Repository
public interface AppRepository extends JpaRepository<AppDetails, Long> {

    List<AppDetails> findByAppNameContainingIgnoreCase(String appName);

    List<AppDetails> findByGenre(String genre);

    List<AppDetails> findByRatingGreaterThanEqual(Double rating);

    List<AppDetails> findByAppOwner_AppOwnerId(Long appOwnerId);
}