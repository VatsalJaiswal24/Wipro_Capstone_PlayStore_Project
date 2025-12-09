package com.capstone.owner.service;

import com.capstone.owner.dto.AppDetailsDTO;
import com.capstone.owner.dto.AppOwnerDTO;
import com.capstone.owner.dto.LoginDTO;
import com.capstone.owner.entity.AppDetails;
import com.capstone.owner.entity.AppOwner;
import java.util.List;

public interface OwnerService {

    String registerOwner(AppOwnerDTO ownerDTO);

    AppOwner loginOwner(LoginDTO loginDTO);

    String addNewApp(AppDetailsDTO appDTO);

    List<AppDetails> getMyApps(Long ownerId);

    List<AppDetails> getAllApps();

    List<AppDetails> getAppsByGenre(String genre);

    AppDetails getAppById(Long appId);
}