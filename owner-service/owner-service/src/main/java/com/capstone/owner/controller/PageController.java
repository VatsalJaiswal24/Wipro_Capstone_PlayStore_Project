package com.capstone.owner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/my-apps")
    public String myApps() {
        return "myapps";
    }

    @GetMapping("/add-app")
    public String addApp() {
        return "addapp";
    }

    @GetMapping("/users")
    public String users() {
        return "users";
    }
}
