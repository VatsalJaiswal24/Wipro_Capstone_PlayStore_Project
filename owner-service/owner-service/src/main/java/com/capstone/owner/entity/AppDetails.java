package com.capstone.owner.entity;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDate;

@Entity
@Table(name = "app_details")
public class AppDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long appId;

    private String appName;
    private String description;
    private LocalDate releaseDate;
    private String version;
    private Double rating = 0.0;
    private String genre;
    private String appType;
    private Double price = 0.0;
    private Long downloadCount = 0L;
    private Boolean isActive = true;

    @ManyToOne
    @JoinColumn(name = "app_owner_id")
    @JsonIgnore
    private AppOwner appOwner;

    public Long getAppId() {
        return appId;
    }

    public void setAppId(Long appId) {
        this.appId = appId;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getAppType() {
        return appType;
    }

    public void setAppType(String appType) {
        this.appType = appType;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Long getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(Long downloadCount) {
        this.downloadCount = downloadCount;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public AppOwner getAppOwner() {
        return appOwner;
    }

    public void setAppOwner(AppOwner appOwner) {
        this.appOwner = appOwner;
    }
}