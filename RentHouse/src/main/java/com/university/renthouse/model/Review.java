package com.university.renthouse.model;

public class Review {
    private final String clientName;
    private final double rating;
    private final String comment;
    private final String imageUrl;

    public Review(String clientName, double rating, String comment, String imageUrl) {
        this.clientName = clientName;
        this.rating = rating;
        this.comment = comment;
        this.imageUrl = imageUrl;
    }

    public String getClientName() {
        return clientName;
    }

    public double getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}