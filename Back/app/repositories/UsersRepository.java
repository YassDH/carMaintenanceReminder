package repositories;

import com.google.inject.Inject;
import models.User;
import org.mindrot.jbcrypt.BCrypt;
import play.db.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.Optional;

public class UsersRepository {
    private final Database db;

    @Inject
    public UsersRepository(Database db) {
        this.db = db;
    }

    private String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }
    public long addUser(User user) throws SQLException{
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, hashPassword(user.getPassword()));

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            return generatedKeys.getLong(1);
                        } else {

                            throw new SQLException("Impossible de récupérer l'auto-generated ID !");
                        }
                    }
                } else {
                    throw new SQLException("Impossible d'ajouter l'utilisateur !");
                }
             } catch (SQLException e) {
                throw new SQLException(e.getMessage());
             }
    }

    public Optional<User> findUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("username");
                    String userEmail = rs.getString("email");
                    String password = rs.getString("password");

                    User user = new User(id, name, userEmail, password);
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<User> findUserById(long id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection connection = db.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setLong(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("username");
                    String email = rs.getString("email");
                    String password = rs.getString("password");

                    User user = new User(id, name, email, password);
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
