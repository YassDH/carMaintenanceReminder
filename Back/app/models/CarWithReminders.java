package models;

import java.util.ArrayList;
import java.util.List;

public class CarWithReminders {
    private long id;
    private long userID;
    private String brand;
    private String model;
    private String libelle;
    private List<Reminder> reminders;

    public CarWithReminders(long id, long userID, String brand, String model, String libelle, List<Reminder> reminders) {
        this.id = id;
        this.userID = userID;
        this.brand = brand;
        this.model = model;
        this.libelle = libelle;
        this.reminders = reminders;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public List<Reminder> getReminders() {
        return reminders;
    }

    public void setReminders(ArrayList<Reminder> reminders) {
        this.reminders = reminders;
    }
}
