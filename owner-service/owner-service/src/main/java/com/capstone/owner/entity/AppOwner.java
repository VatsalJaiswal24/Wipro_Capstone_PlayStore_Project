package com.capstone.owner.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "app_owner")
public class AppOwner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long appOwnerId;

    private String firstName;
    private String lastName;

    @Column(unique = true, nullable = false)
    private String userName;

    private String password;
    private String email;
    private String mobileNo;
    private String address;
    private String city;
    private String state;
    private String country;

    @OneToMany(mappedBy = "appOwner", cascade = CascadeType.ALL)
    private List<AppDetails> apps;

    public Long getAppOwnerId() {
        return appOwnerId;
    }

    public void setAppOwnerId(Long appOwnerId) {
        this.appOwnerId = appOwnerId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public List<AppDetails> getApps() {
        return apps;
    }

    public void setApps(List<AppDetails> apps) {
        this.apps = apps;
    }
}