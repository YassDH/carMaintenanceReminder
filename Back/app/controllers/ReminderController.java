package controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.inject.Inject;
import jwt.JwtAuth;
import models.Car;
import models.Reminder;
import models.RemindersColors;
import models.User;
import play.libs.Json;
import play.mvc.Http;
import play.mvc.Result;
import repositories.CarsRepository;
import repositories.RemindersRepository;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static play.mvc.Results.*;

public class ReminderController {
    private final CarsRepository carsRepository;
    private final RemindersRepository remindersRepository;
    private final JwtAuth jwt;
    @Inject
    public ReminderController(CarsRepository carsRepository, RemindersRepository remindersRepository, JwtAuth jwt) {
        this.carsRepository = carsRepository;
        this.remindersRepository = remindersRepository;
        this.jwt = jwt;
    }
    public Result addReminder(Http.Request request, Long carID) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        Optional<Car> carFound = carsRepository.getCarbyId(carID);
        if(carFound.isEmpty() || carFound.get().getUserID() != userAuthenticated.get().getId()){
            result.put("status", "error");
            result.put("message", "La voiture soit elle a été supprimée soit elle vous n'appartient pas !");
            return badRequest(result);
        }

        JsonNode json = request.body().asJson();
        if (json == null){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        Reminder reminderToAdd = Json.fromJson(json, Reminder.class);
        reminderToAdd.setCarID(carID);
        if(reminderToAdd.getName().isEmpty() || reminderToAdd.getPrice() == 0 ){
            result.put("status", "error");
            result.put("message", "Les champs nom et montant doivent être remplis !");
            return badRequest(result);
        }
        if(remindersRepository.addReminder(reminderToAdd)){
            result.put("status", "sucess");
            result.put("message", "Rappel ajouté avec succès !");
            return ok(result);
        }else{
            result.put("status", "error");
            result.put("message", "Une erreur est survenue veuillez réessayer !");
            return internalServerError(result);
        }
    }

    public Result deleteReminder(Http.Request request, Long reminderID) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        Optional<Reminder> reminderFound = remindersRepository.getReminderById(reminderID);
        if(reminderFound.isEmpty()){
            result.put("status", "error");
            result.put("message", "Le rappel n'existe pas !");
            return badRequest(result);
        }
        Optional<Car> carFound = carsRepository.getCarbyId(reminderFound.get().getCarID());
        if(carFound.isEmpty() || carFound.get().getUserID() != userAuthenticated.get().getId()){
            result.put("status", "error");
            result.put("message", "Le rappel a soit été supprimé soit la voiture ne vous appartient pas !");
            return badRequest(result);
        }

        if(remindersRepository.deleteReminder(reminderID)){
            result.put("status", "sucess");
            result.put("message", "Rappel supprimé avec succès !");
            return ok(result);
        }else{
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }

    public Result resetReminder(Http.Request request, Long reminderID) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        Optional<Reminder> reminderFound = remindersRepository.getReminderById(reminderID);
        if(reminderFound.isEmpty()){
            result.put("status", "error");
            result.put("message", "Le rappel n'existe pas !");
            return badRequest(result);
        }
        Optional<Car> carFound = carsRepository.getCarbyId(reminderFound.get().getCarID());
        if(carFound.isEmpty() || carFound.get().getUserID() != userAuthenticated.get().getId()){
            result.put("status", "error");
            result.put("message", "Le rappel a soit été supprimé soit la voiture ne vous appartient pas !");
            return badRequest(result);
        }
        boolean queryResult=false;
        if(reminderFound.get().getDistance_periodicty() == 0 && reminderFound.get().getTime_periodicty() == 0){
            queryResult = remindersRepository.deleteReminder(reminderID);
        }else if(reminderFound.get().getDistance_periodicty() == 0 && reminderFound.get().getTime_periodicty() != 0){
            queryResult = remindersRepository.updateReminderTime(reminderFound.get());
        }else if(reminderFound.get().getDistance_periodicty() != 0 && reminderFound.get().getTime_periodicty() == 0){
            queryResult = remindersRepository.updateReminderDistance(reminderFound.get());
        }else{
            queryResult = remindersRepository.updateReminderTimeAndDistance(reminderFound.get());
        }
        if(queryResult){
            result.put("status", "sucess");
            result.put("message", "Rappel mis à jour avec succès !");
            return ok(result);
        }else {
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }
    public Result getRemindersByCar(Http.Request request, Long carID) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        try{
            List<Reminder> reminderList = remindersRepository.getRemindersByCar(carID);
            result.put("status", "sucess");
            result.put("data", Json.toJson(reminderList));
            return ok(result);
        }catch(SQLException e){
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }
    //API TO GET ALL THE USER'S REMINDERS AND SORT THEM IN 3 FIELDS (LESS THAN 1 MONTH, LESS THAN 2 MONTHS, THE REST)
    public Result getRemindersSorted(Http.Request request) throws UnsupportedEncodingException, SQLException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        try{
            List<Car> userCars = carsRepository.getCarsByUser(userAuthenticated.get().getId());
            RemindersColors data = remindersRepository.getRemindersSorted(userCars);
            result.put("status", "sucess");
            result.put("data", Json.toJson(data));
            return ok(result);
        }catch(SQLException e){
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }
}
