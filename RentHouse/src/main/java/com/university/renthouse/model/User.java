package com.university.renthouse.model;

public class User {
    private String email;
    private String password;
    private String username;
    private String phone;

    public User(String email, String password, String username,String phone) {
        this.email = email;
        this.password = password;
        this.username = username;
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }
    
    public String getPhone() {
        return phone;
    }
}