package repositories;

import models.Car;
import models.Reminder;
import models.RemindersColors;
import models.SortedReminders;
import play.db.Database;

import javax.inject.Inject;
import java.sql.*;
import java.sql.Date;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;

public class RemindersRepository {
    private final Database db;
    @Inject
    public RemindersRepository(Database db) {
        this.db = db;
    }
    public Optional<Reminder> getReminderById(Long reminderID){
        Reminder reminder = new Reminder();
        String sql = "SELECT * FROM reminders WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,reminderID);
            try (ResultSet resultSet = ps.executeQuery()) {
                if(resultSet.next()){
                    reminder.setId(resultSet.getLong("id"));
                    reminder.setCarID(resultSet.getLong("carID"));
                    reminder.setName(resultSet.getString("name"));
                    reminder.setDistance(resultSet.getLong("distance"));
                    reminder.setBegin_date(resultSet.getDate("begin_date").toLocalDate().atStartOfDay());
                    reminder.setTime_periodicty(resultSet.getLong("time_periodicty"));
                    reminder.setDistance_periodicty(resultSet.getLong("distance_periodicty"));
                    reminder.setPrice(resultSet.getFloat("price"));

                    return Optional.of(reminder);
                }else {
                    return Optional.empty();
                }

            }
        } catch (SQLException e) {
            return Optional.empty();
        }
    }
    public boolean addReminder(Reminder newReminder){
        String sql = "INSERT INTO reminders (carID, name, begin_date, distance, time_periodicty, distance_periodicty, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, newReminder.getCarID());
            ps.setString(2, newReminder.getName());
            ps.setDate(3, new Date(newReminder.getBegin_date().toInstant(ZoneOffset.UTC).toEpochMilli()));
            ps.setLong(4, newReminder.getDistance());
            ps.setLong(5, newReminder.getTime_periodicty());
            ps.setLong(6, newReminder.getDistance_periodicty());
            ps.setFloat(7, newReminder.getPrice());
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteReminder(Long reminderID){
        String sql = "DELETE FROM reminders WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,reminderID);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean updateReminderTime(Reminder reminderToUpdate){
        String sql = "UPDATE reminders SET begin_date = ? WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, new Date(reminderToUpdate.getBegin_date().plusMonths(reminderToUpdate.getTime_periodicty()).toInstant(ZoneOffset.UTC).toEpochMilli()));
            ps.setLong(2, reminderToUpdate.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateReminderDistance(Reminder reminderToUpdate){
        String sql = "UPDATE reminders SET distance = ? WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, reminderToUpdate.getDistance()+reminderToUpdate.getDistance_periodicty());
            ps.setLong(2, reminderToUpdate.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateReminderTimeAndDistance(Reminder reminderToUpdate){
        String sql = "UPDATE reminders SET distance = ?, begin_date = ? WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, reminderToUpdate.getDistance()+reminderToUpdate.getDistance_periodicty());
            ps.setDate(2, new Date(reminderToUpdate.getBegin_date().plusMonths(reminderToUpdate.getTime_periodicty()).toInstant(ZoneOffset.UTC).toEpochMilli()));
            ps.setLong(3, reminderToUpdate.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Reminder> getRemindersByCar(Long carID) throws SQLException {
        List<Reminder> reminderDateList = new ArrayList<>();
        List<Reminder> reminderDistanceList = new ArrayList<>();
        String sql = "SELECT * FROM reminders WHERE carID = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,carID);
            try (ResultSet resultSet = ps.executeQuery()) {
                while (resultSet.next()) {
                    Reminder reminder = new Reminder();
                    reminder.setId(resultSet.getLong("id"));
                    reminder.setCarID(resultSet.getLong("carID"));
                    reminder.setName(resultSet.getString("name"));
                    reminder.setDistance(resultSet.getLong("distance"));
                    reminder.setBegin_date(resultSet.getDate("begin_date").toLocalDate().atStartOfDay());
                    reminder.setTime_periodicty(resultSet.getLong("time_periodicty"));
                    reminder.setDistance_periodicty(resultSet.getLong("distance_periodicty"));
                    reminder.setPrice(resultSet.getFloat("price"));
                    if (reminder.getTime_periodicty() == 0){
                        reminderDistanceList.add(reminder);
                    }else{
                        reminderDateList.add(reminder);
                    }
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Une erreur est survenue !");
        }
        reminderDateList.sort(new remindersDateComparator());
        reminderDateList.addAll(reminderDistanceList);
        return reminderDateList;
    }


    public RemindersColors getRemindersSorted(List<Car> userCars) throws SQLException {
        List<SortedReminders> redSortedList = new ArrayList<>();
        List<SortedReminders> yellowSortedList = new ArrayList<>();
        List<SortedReminders> greenSortedList = new ArrayList<>();
        List<SortedReminders> graySortedList = new ArrayList<>();
        for(Car car : userCars){
            try {
                List<Reminder> carReminders = getRemindersByCar(car.getId());
                for(Reminder reminder : carReminders){
                    SortedReminders toAdd = new SortedReminders(reminder.getId(), reminder.getName(), car.getLibelle(), reminder.getBegin_date(), reminder.getDistance(), reminder.getTime_periodicty(), reminder.getDistance_periodicty());
                    if(reminder.getTime_periodicty() == 0){
                        graySortedList.add(toAdd);
                        continue;
                    }
                    Duration duration = Duration.between(LocalDateTime.now(), reminder.getBegin_date().plusMonths(reminder.getTime_periodicty()));
                    long monthsDifference = duration.toDays() / 30;
                    if(monthsDifference < 1){
                        redSortedList.add(toAdd);
                    }else if(monthsDifference < 2){
                        yellowSortedList.add(toAdd);
                    }else{
                        greenSortedList.add(toAdd);
                    }
                }
            }catch (SQLException e){
                throw new SQLException("Une erreur est survenue !");
            }
        }
        redSortedList.sort(new sortedRemindersComparator());
        yellowSortedList.sort(new sortedRemindersComparator());
        greenSortedList.sort(new sortedRemindersComparator());
        greenSortedList.addAll(graySortedList);

        return new RemindersColors(redSortedList, yellowSortedList, greenSortedList);
    }
}
class sortedRemindersComparator implements Comparator<SortedReminders> {
    @Override
    public int compare(SortedReminders rem1, SortedReminders rem2) {
        return rem1.getBegin_date().plusMonths(rem1.getTime_periodicty()).compareTo(rem2.getBegin_date().plusMonths(rem2.getTime_periodicty()));
    }
}
class remindersDateComparator implements Comparator<Reminder> {
    @Override
    public int compare(Reminder rem1, Reminder rem2) {
        return rem1.getBegin_date().plusMonths(rem1.getTime_periodicty()).compareTo(rem2.getBegin_date().plusMonths(rem2.getTime_periodicty()));
    }
}
