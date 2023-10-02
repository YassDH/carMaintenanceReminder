// @GENERATOR:play-routes-compiler
// @SOURCE:conf/routes

import play.api.routing.JavaScriptReverseRoute


import _root_.controllers.Assets.Asset
import _root_.play.libs.F

// @LINE:6
package controllers.javascript {

  // @LINE:6
  class ReverseUserController(_prefix: => String) {

    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:6
    def signUp: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.UserController.signUp",
      """
        function() {
          return _wA({method:"POST", url:"""" + _prefix + { _defaultPrefix } + """" + "user/register"})
        }
      """
    )
  
    // @LINE:7
    def logIn: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.UserController.logIn",
      """
        function() {
          return _wA({method:"POST", url:"""" + _prefix + { _defaultPrefix } + """" + "user/login"})
        }
      """
    )
  
    // @LINE:9
    def isAuthenticated: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.UserController.isAuthenticated",
      """
        function() {
          return _wA({method:"GET", url:"""" + _prefix + { _defaultPrefix } + """" + "user/verify"})
        }
      """
    )
  
    // @LINE:11
    def getUserName: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.UserController.getUserName",
      """
        function() {
          return _wA({method:"GET", url:"""" + _prefix + { _defaultPrefix } + """" + "user/name"})
        }
      """
    )
  
  }

  // @LINE:15
  class ReverseCarController(_prefix: => String) {

    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:15
    def add: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.CarController.add",
      """
        function() {
          return _wA({method:"POST", url:"""" + _prefix + { _defaultPrefix } + """" + "cars/add"})
        }
      """
    )
  
    // @LINE:17
    def getCarsByUser: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.CarController.getCarsByUser",
      """
        function() {
          return _wA({method:"GET", url:"""" + _prefix + { _defaultPrefix } + """" + "cars"})
        }
      """
    )
  
    // @LINE:19
    def deleteCar: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.CarController.deleteCar",
      """
        function(id0) {
          return _wA({method:"DELETE", url:"""" + _prefix + { _defaultPrefix } + """" + "cars/" + encodeURIComponent((""" + implicitly[play.api.mvc.PathBindable[Long]].javascriptUnbind + """)("id", id0))})
        }
      """
    )
  
  }

  // @LINE:23
  class ReverseReminderController(_prefix: => String) {

    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:31
    def getRemindersByCar: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.ReminderController.getRemindersByCar",
      """
        function(carID0) {
          return _wA({method:"GET", url:"""" + _prefix + { _defaultPrefix } + """" + "reminders/" + encodeURIComponent((""" + implicitly[play.api.mvc.PathBindable[Long]].javascriptUnbind + """)("carID", carID0))})
        }
      """
    )
  
    // @LINE:27
    def getRemindersSorted: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.ReminderController.getRemindersSorted",
      """
        function() {
          return _wA({method:"GET", url:"""" + _prefix + { _defaultPrefix } + """" + "reminders/sortedall"})
        }
      """
    )
  
    // @LINE:29
    def deleteReminder: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.ReminderController.deleteReminder",
      """
        function(id0) {
          return _wA({method:"DELETE", url:"""" + _prefix + { _defaultPrefix } + """" + "reminders/" + encodeURIComponent((""" + implicitly[play.api.mvc.PathBindable[Long]].javascriptUnbind + """)("id", id0))})
        }
      """
    )
  
    // @LINE:25
    def resetReminder: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.ReminderController.resetReminder",
      """
        function(id0) {
          return _wA({method:"PATCH", url:"""" + _prefix + { _defaultPrefix } + """" + "reminders/reset/" + encodeURIComponent((""" + implicitly[play.api.mvc.PathBindable[Long]].javascriptUnbind + """)("id", id0))})
        }
      """
    )
  
    // @LINE:23
    def addReminder: JavaScriptReverseRoute = JavaScriptReverseRoute(
      "controllers.ReminderController.addReminder",
      """
        function(carID0) {
          return _wA({method:"POST", url:"""" + _prefix + { _defaultPrefix } + """" + "reminders/add/" + encodeURIComponent((""" + implicitly[play.api.mvc.PathBindable[Long]].javascriptUnbind + """)("carID", carID0))})
        }
      """
    )
  
  }


}
