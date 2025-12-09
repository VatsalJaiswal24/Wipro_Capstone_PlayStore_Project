package com.capstone.owner.dto;

import java.time.LocalDate;

public class AppDetailsDTO {

    private String appName;
    private String description;
    private String version;
    private String genre;
    private String appType;
    private Double price;
    private Long appOwnerId;

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

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
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

    public Long getAppOwnerId() {
        return appOwnerId;
    }

    public void setAppOwnerId(Long appOwnerId) {
        this.appOwnerId = appOwnerId;
    }
}