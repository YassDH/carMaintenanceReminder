package repositories;

import models.Car;
import play.db.Database;

import javax.inject.Inject;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

public class CarsRepository {
    private final Database db;
    @Inject
    public CarsRepository(Database db) {
        this.db = db;
    }

    public boolean addCar(Car newCar){
        String sql = "INSERT INTO cars (userID, brand, model, libelle) VALUES (?, ?, ?, ?)";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, newCar.getUserID());
            ps.setString(2, newCar.getBrand());
            ps.setString(3, newCar.getModel());
            ps.setString(4, newCar.getLibelle());
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            return false;
        }
    }

    public Optional<Car> getCarbyId(Long carID){
        Car car = new Car();
        String sql = "SELECT * FROM cars WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,carID);
            try (ResultSet resultSet = ps.executeQuery()) {
                if(resultSet.next()){
                    car.setId(resultSet.getLong("id"));
                    car.setUserID(resultSet.getLong("userID"));
                    car.setModel(resultSet.getString("model"));
                    car.setBrand(resultSet.getString("brand"));
                    car.setLibelle(resultSet.getString("libelle"));
                    return Optional.of(car);
                }else {
                    return Optional.empty();
                }

                }
            } catch (SQLException e) {
                return Optional.empty();
            }
    }
    public List<Car> getCarsByUser(Long userID) throws SQLException {
        List<Car> carList = new ArrayList<>();
        String sql = "SELECT * FROM cars WHERE userID = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,userID);
            try (ResultSet resultSet = ps.executeQuery()) {
                while (resultSet.next()) {
                    Car car = new Car();
                    car.setId(resultSet.getLong("id"));
                    car.setUserID(resultSet.getLong("userID"));
                    car.setModel(resultSet.getString("model"));
                    car.setBrand(resultSet.getString("brand"));
                    car.setLibelle(resultSet.getString("libelle"));
                    carList.add(car);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Une erreur est survenue !");
        }
        return carList;
    }

    public boolean deleteCar(Long userID, Long carID){
        String sql = "DELETE FROM cars WHERE userID = ? AND id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1,userID);
            ps.setLong(2,carID);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            return false;
        }
    }
}
