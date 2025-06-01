package com.university.renthouse.model;

public class ContactMessage {
    private String name;
    private String email;
    private String number;
    private String message;

    public ContactMessage(String name, String email, String number, String message) {
        this.name = name;
        this.email = email;
        this.number = number;
        this.message = message;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getNumber() {
        return number;
    }

    public String getMessage() {
        return message;
    }
}