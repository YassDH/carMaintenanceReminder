package models;

import java.util.List;

public class RemindersColors {
    private List<SortedReminders> red;
    private List<SortedReminders> yellow;
    private List<SortedReminders> green;

    public RemindersColors(List<SortedReminders> red, List<SortedReminders> yellow, List<SortedReminders> green) {
        this.red = red;
        this.yellow = yellow;
        this.green = green;
    }

    public List<SortedReminders> getRed() {
        return red;
    }

    public void setRed(List<SortedReminders> red) {
        this.red = red;
    }

    public List<SortedReminders> getYellow() {
        return yellow;
    }

    public void setYellow(List<SortedReminders> yellow) {
        this.yellow = yellow;
    }

    public List<SortedReminders> getGreen() {
        return green;
    }

    public void setGreen(List<SortedReminders> green) {
        this.green = green;
    }
}
