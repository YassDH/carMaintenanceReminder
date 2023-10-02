package controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.inject.Inject;

import models.User;
import repositories.UsersRepository;
import jwt.JwtAuth;
import org.mindrot.jbcrypt.BCrypt;

import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserController extends Controller {

    private final UsersRepository usersRepository;
    private final JwtAuth jwt;
    @Inject
    public UserController(UsersRepository usersRepository, JwtAuth jwt) {
        this.usersRepository = usersRepository;
        this.jwt = jwt;
    }
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
    public Result signUp(Http.Request request) throws UnsupportedEncodingException {
        ObjectNode result = Json.newObject();
        JsonNode json = request.body().asJson();
        if (json == null){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        String username = json.findPath("username").textValue();
        String email = json.findPath("email").textValue();
        String password = json.findPath("password").textValue();
        String confirmPassword = json.findPath("confirmPassword").textValue();
        if(username==null|| email==null || password==null || confirmPassword==null
                || username.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        if (!password.equals(confirmPassword)) {
            result.put("status", "error");
            result.put("message", "Les mots de passes sont differents !");
            return badRequest(result);
        }
        if(!isValidEmail(email)){
            result.put("status", "error");
            result.put("message", "Veuillez saisir un email valide !");
            return badRequest(result);
        }
        User newUser = new User(username,email,password);

        if(usersRepository.findUserByEmail(json.findPath("email").textValue()).isPresent()){
            result.put("status", "error");
            result.put("message", "L'email existe déjà !");
            return badRequest(result);
        }

        try{
            long userID = usersRepository.addUser(newUser);
            String token = jwt.generateToken(userID);
            result.put("status", "sucess");
            result.put("token", token);
            return ok(result);
        }catch (SQLException e){
            result.put("status", "error");
            result.put("message", "Impossible d'ajouter l'utilisateur !");
            return badRequest(result);
        }
    }
    public Result logIn(Http.Request request) throws UnsupportedEncodingException {
        ObjectNode result = Json.newObject();
        JsonNode json = request.body().asJson();
        if (json == null){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        String email = json.findPath("email").textValue();
        String password = json.findPath("password").textValue();
        if(email==null || password==null || email.isEmpty() || password.isEmpty()){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        if(!isValidEmail(email)){
            result.put("status", "error");
            result.put("message", "Veuillez saisir un email valide !");
            return badRequest(result);
        }
        Optional<User> userFound = usersRepository.findUserByEmail(json.findPath("email").textValue());
        if(userFound.isPresent()){
            if(BCrypt.checkpw(password, userFound.get().getPassword())){
                String token = jwt.generateToken(userFound.get().getId());
                result.put("status", "sucess");
                result.put("token", token);
                return ok(result);
            }else{
                result.put("status", "error");
                result.put("message", "Impossible de se connecter, veuillez vérifier vos coordonnées !");
                return notFound(result);
            }
        }else{
            result.put("status", "error");
            result.put("message", "Impossible de se connecter, veuillez vérifier vos coordonnées !");
            return notFound(result);
        }
    }
    public Result isAuthenticated(Http.Request request) throws UnsupportedEncodingException {
        ObjectNode result = Json.newObject();
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("authenticated", false);
            return unauthorized(result);
        }

        //If the user is authenticated
        result.put("status", "sucess");
        result.put("authenticated", true);
        return ok(result);
    }
    public Result getUserName(Http.Request request) throws UnsupportedEncodingException {
        ObjectNode result = Json.newObject();
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        result.put("status", "sucess");
        result.put("message", userAuthenticated.get().getName());
        return ok(result);
    }
}