// @GENERATOR:play-routes-compiler
// @SOURCE:conf/routes

import play.api.mvc.Call


import _root_.controllers.Assets.Asset
import _root_.play.libs.F

// @LINE:6
package controllers {

  // @LINE:6
  class ReverseUserController(_prefix: => String) {
    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:6
    def signUp(): Call = {
      
      Call("POST", _prefix + { _defaultPrefix } + "user/register")
    }
  
    // @LINE:7
    def logIn(): Call = {
      
      Call("POST", _prefix + { _defaultPrefix } + "user/login")
    }
  
    // @LINE:9
    def isAuthenticated(): Call = {
      
      Call("GET", _prefix + { _defaultPrefix } + "user/verify")
    }
  
    // @LINE:11
    def getUserName(): Call = {
      
      Call("GET", _prefix + { _defaultPrefix } + "user/name")
    }
  
  }

  // @LINE:15
  class ReverseCarController(_prefix: => String) {
    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:15
    def add(): Call = {
      
      Call("POST", _prefix + { _defaultPrefix } + "cars/add")
    }
  
    // @LINE:17
    def getCarsByUser(): Call = {
      
      Call("GET", _prefix + { _defaultPrefix } + "cars")
    }
  
    // @LINE:19
    def deleteCar(id:Long): Call = {
      
      Call("DELETE", _prefix + { _defaultPrefix } + "cars/" + play.core.routing.dynamicString(implicitly[play.api.mvc.PathBindable[Long]].unbind("id", id)))
    }
  
  }

  // @LINE:23
  class ReverseReminderController(_prefix: => String) {
    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:31
    def getRemindersByCar(carID:Long): Call = {
      
      Call("GET", _prefix + { _defaultPrefix } + "reminders/" + play.core.routing.dynamicString(implicitly[play.api.mvc.PathBindable[Long]].unbind("carID", carID)))
    }
  
    // @LINE:27
    def getRemindersSorted(): Call = {
      
      Call("GET", _prefix + { _defaultPrefix } + "reminders/sortedall")
    }
  
    // @LINE:29
    def deleteReminder(id:Long): Call = {
      
      Call("DELETE", _prefix + { _defaultPrefix } + "reminders/" + play.core.routing.dynamicString(implicitly[play.api.mvc.PathBindable[Long]].unbind("id", id)))
    }
  
    // @LINE:25
    def resetReminder(id:Long): Call = {
      
      Call("PATCH", _prefix + { _defaultPrefix } + "reminders/reset/" + play.core.routing.dynamicString(implicitly[play.api.mvc.PathBindable[Long]].unbind("id", id)))
    }
  
    // @LINE:23
    def addReminder(carID:Long): Call = {
      
      Call("POST", _prefix + { _defaultPrefix } + "reminders/add/" + play.core.routing.dynamicString(implicitly[play.api.mvc.PathBindable[Long]].unbind("carID", carID)))
    }
  
  }


}
