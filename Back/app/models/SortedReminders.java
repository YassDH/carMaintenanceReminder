package models;

import java.time.LocalDateTime;

public class SortedReminders {
    private long id;
    private String reminderName;
    private String carName;
    private LocalDateTime begin_date;
    private Long distance;
    private Long time_periodicty;
    private Long distance_periodicty;

    public SortedReminders(long id, String reminderName, String carName, LocalDateTime begin_date, Long distance, Long time_periodicty, Long distance_periodicty) {
        this.id = id;
        this.reminderName = reminderName;
        this.carName = carName;
        this.begin_date = begin_date;
        this.distance = distance;
        this.time_periodicty = time_periodicty;
        this.distance_periodicty = distance_periodicty;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getReminderName() {
        return reminderName;
    }

    public void setReminderName(String reminderName) {
        this.reminderName = reminderName;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
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
}
