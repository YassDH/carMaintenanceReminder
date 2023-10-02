package controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.google.inject.Inject;
import jwt.JwtAuth;

import models.Car;
import models.CarWithReminders;
import models.Reminder;
import models.User;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Http;
import play.mvc.Result;
import repositories.CarsRepository;
import repositories.RemindersRepository;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CarController extends Controller{
    private final CarsRepository carsRepository;
    private final RemindersRepository remindersRepository;
    private final JwtAuth jwt;
    @Inject
    public CarController(CarsRepository carsRepository, RemindersRepository remindersRepository, JwtAuth jwt) {
        this.carsRepository = carsRepository;
        this.remindersRepository = remindersRepository;
        this.jwt = jwt;
    }

    public Result add(Http.Request request) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }

        //If the user is authenticated
        JsonNode json = request.body().asJson();
        if (json == null){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        String brand = json.findPath("brand").textValue();
        String model = json.findPath("model").textValue();
        String libelle = json.findPath("libelle").textValue();
        if(brand == null || model == null || libelle == null ||
        brand.isEmpty() || model.isEmpty() || libelle.isEmpty() ){
            result.put("status", "error");
            result.put("message", "Tous les champs doivent être remplis !");
            return badRequest(result);
        }
        Car newCar = new Car(userAuthenticated.get().getId(), brand, model, libelle);
        if(carsRepository.addCar(newCar)){
            result.put("status", "sucess");
            result.put("message", "Voiture ajoutée avec succès !");
            return ok(result);
        }
        result.put("status", "error");
        result.put("message", "Une erreur est survenue veuillez réessayer !");
        return internalServerError(result);
    }

    public Result getCarsByUser(Http.Request request) throws UnsupportedEncodingException {
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
            List<Car> carList = carsRepository.getCarsByUser(userAuthenticated.get().getId());
            List<CarWithReminders> resultList = new ArrayList<>();
            for(Car car : carList){
                List<Reminder> reminders = remindersRepository.getRemindersByCar(car.getId());
                resultList.add(new CarWithReminders(car.getId(), car.getUserID(), car.getBrand(), car.getModel(), car.getLibelle(), reminders));
            }
            result.put("status", "sucess");
            result.put("data", Json.toJson(resultList));
            return ok(result);
        }catch(SQLException e){
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }

    public Result deleteCar(Http.Request request, Long id) throws UnsupportedEncodingException {
        //Check if the user is authenticated
        Optional<User> userAuthenticated = jwt.isAuthenticated(request);
        ObjectNode result = Json.newObject();
        if(userAuthenticated.isEmpty()){
            result.put("status", "error");
            result.put("message", "Vous devez être connecté !");
            return unauthorized(result);
        }
        //If the user is authenticated
        if(carsRepository.deleteCar(userAuthenticated.get().getId(), id)){
            result.put("status", "sucess");
            result.put("message", "Voiture supprimée avec succès !");
            return ok(result);
        }else{
            result.put("status", "error");
            result.put("message", "Une erreur est survenue !");
            return internalServerError(result);
        }
    }


}
