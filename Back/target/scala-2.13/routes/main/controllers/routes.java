// @GENERATOR:play-routes-compiler
// @SOURCE:conf/routes

package controllers;

import router.RoutesPrefix;

public class routes {
  
  public static final controllers.ReverseUserController UserController = new controllers.ReverseUserController(RoutesPrefix.byNamePrefix());
  public static final controllers.ReverseCarController CarController = new controllers.ReverseCarController(RoutesPrefix.byNamePrefix());
  public static final controllers.ReverseReminderController ReminderController = new controllers.ReverseReminderController(RoutesPrefix.byNamePrefix());

  public static class javascript {
    
    public static final controllers.javascript.ReverseUserController UserController = new controllers.javascript.ReverseUserController(RoutesPrefix.byNamePrefix());
    public static final controllers.javascript.ReverseCarController CarController = new controllers.javascript.ReverseCarController(RoutesPrefix.byNamePrefix());
    public static final controllers.javascript.ReverseReminderController ReminderController = new controllers.javascript.ReverseReminderController(RoutesPrefix.byNamePrefix());
  }

}
