package com.capstone.owner.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.capstone.owner.dto.AppDetailsDTO;
import com.capstone.owner.dto.AppOwnerDTO;
import com.capstone.owner.dto.LoginDTO;
import com.capstone.owner.entity.AppDetails;
import com.capstone.owner.entity.AppOwner;
import com.capstone.owner.repository.AppOwnerRepository;
import com.capstone.owner.repository.AppRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class OwnerServiceImpl implements OwnerService {

    @Autowired
    private AppOwnerRepository ownerRepository;

    @Autowired
    private AppRepository appRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public String registerOwner(AppOwnerDTO ownerDTO) {
        if (ownerRepository.existsByUserName(ownerDTO.getUserName())) {
            return "Error: Username is already taken!";
        }

        AppOwner owner = new AppOwner();
        owner.setFirstName(ownerDTO.getFirstName());
        owner.setLastName(ownerDTO.getLastName());
        owner.setUserName(ownerDTO.getUserName());
        owner.setPassword(passwordEncoder.encode(ownerDTO.getPassword()));
        owner.setEmail(ownerDTO.getEmail());
        owner.setMobileNo(ownerDTO.getMobileNo());
        owner.setAddress(ownerDTO.getAddress());
        owner.setCity(ownerDTO.getCity());
        owner.setState(ownerDTO.getState());
        owner.setCountry(ownerDTO.getCountry());

        ownerRepository.save(owner);
        return "Success: Owner registered successfully!";
    }

    @Override
    public AppOwner loginOwner(LoginDTO loginDTO) {
        Optional<AppOwner> ownerOpt = ownerRepository.findByUserName(loginDTO.getUserName());
        if (ownerOpt.isPresent()) {
            AppOwner owner = ownerOpt.get();
            if (passwordEncoder.matches(loginDTO.getPassword(), owner.getPassword())) {
                return owner;
            }
        }
        return null;
    }

    @Override
    public String addNewApp(AppDetailsDTO appDTO) {
        Optional<AppOwner> ownerOpt = ownerRepository.findById(appDTO.getAppOwnerId());
        
        if (ownerOpt.isEmpty()) {
            return "Error: Owner not found!";
        }

        AppDetails app = new AppDetails();
        app.setAppName(appDTO.getAppName());
        app.setDescription(appDTO.getDescription());
        app.setVersion(appDTO.getVersion());
        app.setGenre(appDTO.getGenre());
        app.setAppType(appDTO.getAppType());
        app.setPrice(appDTO.getPrice());
        app.setReleaseDate(LocalDate.now());
        app.setRating(0.0);
        app.setDownloadCount(0L);
        app.setIsActive(true);
        app.setAppOwner(ownerOpt.get());

        appRepository.save(app);
        return "Success: App added successfully!";
    }

    @Override
    public List<AppDetails> getMyApps(Long ownerId) {
        return appRepository.findByAppOwner_AppOwnerId(ownerId);
    }

    @Override
    public List<AppDetails> getAllApps() {
        return appRepository.findAll();
    }

    @Override
    public List<AppDetails> getAppsByGenre(String genre) {
        return appRepository.findByGenre(genre);
    }

    @Override
    public AppDetails getAppById(Long appId) {
        return appRepository.findById(appId).orElse(null);
    }
}