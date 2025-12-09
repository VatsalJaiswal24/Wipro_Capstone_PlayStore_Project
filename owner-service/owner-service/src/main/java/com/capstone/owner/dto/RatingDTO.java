package com.capstone.owner.dto;

public class RatingDTO {
    private Long appId;
    private Long userId;
    private String userName;
    private Integer stars;

    public RatingDTO() {
    }

    public RatingDTO(Long appId, Long userId, String userName, Integer stars) {
        this.appId = appId;
        this.userId = userId;
        this.userName = userName;
        this.stars = stars;
    }

    public Long getAppId() {
        return appId;
    }

    public void setAppId(Long appId) {
        this.appId = appId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getStars() {
        return stars;
    }

    public void setStars(Integer stars) {
        this.stars = stars;
    }
}
