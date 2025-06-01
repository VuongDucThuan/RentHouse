package com.university.renthouse.model;

import java.sql.Date;

public class Property {
    private int id;
    private String name;
    private String location;
    private String price;
    private String image;
    private String images;
    private String owner;
    private String phone;
    private String type;
    private String status;
    private Date postedDate;
    private int totalImages;
    private String rooms;
    private String deposit;
    private String propertyStatus;
    private int bedrooms;
    private int bathrooms;
    private int balcony;
    private String area;
    private String age;
    private String roomFloor;
    private String totalFloors;
    private String furnished;
    private String loan;
    private String amenities;
    private String description;

    public Property(int id, String name, String location, String price, String image, String images, String owner, String phone, String type, String status, Date postedDate, int totalImages, String rooms, String deposit, String propertyStatus, int bedrooms, int bathrooms, int balcony, String area, String age, String roomFloor, String totalFloors, String furnished, String loan, String amenities, String description) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.price = price;
        this.image = image;
        this.images = images;
        this.owner = owner;
        this.phone = phone;
        this.type = type;
        this.status = status;
        this.postedDate = postedDate;
        this.totalImages = totalImages;
        this.rooms = rooms;
        this.deposit = deposit;
        this.propertyStatus = propertyStatus;
        this.bedrooms = bedrooms;
        this.bathrooms = bathrooms;
        this.balcony = balcony;
        this.area = area;
        this.age = age;
        this.roomFloor = roomFloor;
        this.totalFloors = totalFloors;
        this.furnished = furnished;
        this.loan = loan;
        this.amenities = amenities;
        this.description = description;
    }

    public Property() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getLocation() { return location; }
    public String getPrice() { return price; }
    public String getImage() { return image; }
    public String getImages() { return images; }
    public String getOwner() { return owner; }
    public String getPhone() { return phone; }
    public String getType() { return type; }
    public String getStatus() { return status; }
    public Date getPostedDate() { return postedDate; }
    public int getTotalImages() { return totalImages; }
    public String getRooms() { return rooms; }
    public String getDeposit() { return deposit; }
    public String getPropertyStatus() { return propertyStatus; }
    public int getBedrooms() { return bedrooms; }
public int getBathrooms() { return bathrooms; }
    public int getBalcony() { return balcony; }
    public String getArea() { return area; }
    public String getAge() { return age; }
    public String getRoomFloor() { return roomFloor; }
    public String getTotalFloors() { return totalFloors; }
    public String getFurnished() { return furnished; }
    public String getLoan() { return loan; }
    public String getAmenities() { return amenities; }
    public String getDescription() { return description; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setLocation(String location) { this.location = location; }
    public void setPrice(String price) { this.price = price; }
    public void setImage(String image) { this.image = image; }
    public void setImages(String images) { this.images = images; }
    public void setOwner(String owner) { this.owner = owner; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setType(String type) { this.type = type; }
    public void setStatus(String status) { this.status = status; }
    public void setPostedDate(Date postedDate) { this.postedDate = postedDate; }
    public void setTotalImages(int totalImages) { this.totalImages = totalImages; }
    public void setRooms(String rooms) { this.rooms = rooms; }
    public void setDeposit(String deposit) { this.deposit = deposit; }
    public void setPropertyStatus(String propertyStatus) { this.propertyStatus = propertyStatus; }
    public void setBedrooms(int bedrooms) { this.bedrooms = bedrooms; }
    public void setBathrooms(int bathrooms) { this.bathrooms = bathrooms; }
    public void setBalcony(int balcony) { this.balcony = balcony; }
    public void setArea(String area) { this.area = area; }
    public void setAge(String age) { this.age = age; }
    public void setRoomFloor(String roomFloor) { this.roomFloor = roomFloor; }
    public void setTotalFloors(String totalFloors) { this.totalFloors = totalFloors; }
    public void setFurnished(String furnished) { this.furnished = furnished; }
    public void setLoan(String loan) { this.loan = loan; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
    public void setDescription(String description) { this.description = description; }
}