package models;

import java.time.LocalDateTime;

public class Reminder {

    private long id;
    private long carID;
    private String name;
    private LocalDateTime begin_date;
    private Long distance;
    private Long time_periodicty;
    private Long distance_periodicty;
    private float price;

    public Reminder(long carID, String name, LocalDateTime begin_date, Long distance, Long time_periodicty, Long distance_periodicty, float price) {
        this.carID = carID;
        this.name = name;
        this.begin_date = begin_date;
        this.distance = distance;
        this.time_periodicty = time_periodicty;
        this.distance_periodicty = distance_periodicty;
        this.price = price;
    }

    public Reminder() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getCarID() {
        return carID;
    }

    public void setCarID(long carID) {
        this.carID = carID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDateTime getBegin_date() {
        return begin_date;
    }

    public void setBegin_date(LocalDateTime begin_date) {
        this.begin_date = begin_date;
    }

    public Long getDistance() {
        return distance;
    }

    public void setDistance(Long distance) {
        this.distance = distance;
    }

    public Long getTime_periodicty() {
        return time_periodicty;
    }

    public void setTime_periodicty(Long time_periodicty) {
        this.time_periodicty = time_periodicty;
    }

    public Long getDistance_periodicty() {
        return distance_periodicty;
    }

    public void setDistance_periodicty(Long distance_periodicty) {
        this.distance_periodicty = distance_periodicty;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }


}
