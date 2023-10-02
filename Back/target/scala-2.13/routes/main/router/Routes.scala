// @GENERATOR:play-routes-compiler
// @SOURCE:conf/routes

package router

import play.core.routing._
import play.core.routing.HandlerInvokerFactory._

import play.api.mvc._

import _root_.controllers.Assets.Asset
import _root_.play.libs.F

class Routes(
  override val errorHandler: play.api.http.HttpErrorHandler, 
  // @LINE:6
  UserController_0: controllers.UserController,
  // @LINE:15
  CarController_1: controllers.CarController,
  // @LINE:23
  ReminderController_2: controllers.ReminderController,
  val prefix: String
) extends GeneratedRouter {

   @javax.inject.Inject()
   def this(errorHandler: play.api.http.HttpErrorHandler,
    // @LINE:6
    UserController_0: controllers.UserController,
    // @LINE:15
    CarController_1: controllers.CarController,
    // @LINE:23
    ReminderController_2: controllers.ReminderController
  ) = this(errorHandler, UserController_0, CarController_1, ReminderController_2, "/")

  def withPrefix(addPrefix: String): Routes = {
    val prefix = play.api.routing.Router.concatPrefix(addPrefix, this.prefix)
    router.RoutesPrefix.setPrefix(prefix)
    new Routes(errorHandler, UserController_0, CarController_1, ReminderController_2, prefix)
  }

  private[this] val defaultPrefix: String = {
    if (this.prefix.endsWith("/")) "" else "/"
  }

  def documentation = List(
    ("""POST""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """user/register""", """controllers.UserController.signUp(request:Request)"""),
    ("""POST""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """user/login""", """controllers.UserController.logIn(request:Request)"""),
    ("""GET""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """user/verify""", """controllers.UserController.isAuthenticated(request:Request)"""),
    ("""GET""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """user/name""", """controllers.UserController.getUserName(request:Request)"""),
    ("""POST""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """cars/add""", """controllers.CarController.add(request:Request)"""),
    ("""GET""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """cars""", """controllers.CarController.getCarsByUser(request:Request)"""),
    ("""DELETE""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """cars/""" + "$" + """id<[^/]+>""", """controllers.CarController.deleteCar(request:Request, id:Long)"""),
    ("""POST""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """reminders/add/""" + "$" + """carID<[^/]+>""", """controllers.ReminderController.addReminder(request:Request, carID:Long)"""),
    ("""PATCH""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """reminders/reset/""" + "$" + """id<[^/]+>""", """controllers.ReminderController.resetReminder(request:Request, id:Long)"""),
    ("""GET""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """reminders/sortedall""", """controllers.ReminderController.getRemindersSorted(request:Request)"""),
    ("""DELETE""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """reminders/""" + "$" + """id<[^/]+>""", """controllers.ReminderController.deleteReminder(request:Request, id:Long)"""),
    ("""GET""", this.prefix + (if(this.prefix.endsWith("/")) "" else "/") + """reminders/""" + "$" + """carID<[^/]+>""", """controllers.ReminderController.getRemindersByCar(request:Request, carID:Long)"""),
    Nil
  ).foldLeft(List.empty[(String,String,String)]) { (s,e) => e.asInstanceOf[Any] match {
    case r @ (_,_,_) => s :+ r.asInstanceOf[(String,String,String)]
    case l => s ++ l.asInstanceOf[List[(String,String,String)]]
  }}


  // @LINE:6
  private[this] lazy val controllers_UserController_signUp0_route = Route("POST",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("user/register")))
  )
  private[this] lazy val controllers_UserController_signUp0_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      UserController_0.signUp(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.UserController",
      "signUp",
      Seq(classOf[play.mvc.Http.Request]),
      "POST",
      this.prefix + """user/register""",
      """ USER ROUTES""",
      Seq()
    )
  )

  // @LINE:7
  private[this] lazy val controllers_UserController_logIn1_route = Route("POST",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("user/login")))
  )
  private[this] lazy val controllers_UserController_logIn1_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      UserController_0.logIn(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.UserController",
      "logIn",
      Seq(classOf[play.mvc.Http.Request]),
      "POST",
      this.prefix + """user/login""",
      """""",
      Seq()
    )
  )

  // @LINE:9
  private[this] lazy val controllers_UserController_isAuthenticated2_route = Route("GET",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("user/verify")))
  )
  private[this] lazy val controllers_UserController_isAuthenticated2_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      UserController_0.isAuthenticated(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.UserController",
      "isAuthenticated",
      Seq(classOf[play.mvc.Http.Request]),
      "GET",
      this.prefix + """user/verify""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:11
  private[this] lazy val controllers_UserController_getUserName3_route = Route("GET",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("user/name")))
  )
  private[this] lazy val controllers_UserController_getUserName3_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      UserController_0.getUserName(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.UserController",
      "getUserName",
      Seq(classOf[play.mvc.Http.Request]),
      "GET",
      this.prefix + """user/name""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:15
  private[this] lazy val controllers_CarController_add4_route = Route("POST",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("cars/add")))
  )
  private[this] lazy val controllers_CarController_add4_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      CarController_1.add(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.CarController",
      "add",
      Seq(classOf[play.mvc.Http.Request]),
      "POST",
      this.prefix + """cars/add""",
      """ CAR ROUTES""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:17
  private[this] lazy val controllers_CarController_getCarsByUser5_route = Route("GET",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("cars")))
  )
  private[this] lazy val controllers_CarController_getCarsByUser5_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      CarController_1.getCarsByUser(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.CarController",
      "getCarsByUser",
      Seq(classOf[play.mvc.Http.Request]),
      "GET",
      this.prefix + """cars""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:19
  private[this] lazy val controllers_CarController_deleteCar6_route = Route("DELETE",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("cars/"), DynamicPart("id", """[^/]+""",true)))
  )
  private[this] lazy val controllers_CarController_deleteCar6_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      CarController_1.deleteCar(fakeValue[play.mvc.Http.Request], fakeValue[Long]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.CarController",
      "deleteCar",
      Seq(classOf[play.mvc.Http.Request], classOf[Long]),
      "DELETE",
      this.prefix + """cars/""" + "$" + """id<[^/]+>""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:23
  private[this] lazy val controllers_ReminderController_addReminder7_route = Route("POST",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("reminders/add/"), DynamicPart("carID", """[^/]+""",true)))
  )
  private[this] lazy val controllers_ReminderController_addReminder7_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      ReminderController_2.addReminder(fakeValue[play.mvc.Http.Request], fakeValue[Long]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.ReminderController",
      "addReminder",
      Seq(classOf[play.mvc.Http.Request], classOf[Long]),
      "POST",
      this.prefix + """reminders/add/""" + "$" + """carID<[^/]+>""",
      """ REMINDER ROUTES""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:25
  private[this] lazy val controllers_ReminderController_resetReminder8_route = Route("PATCH",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("reminders/reset/"), DynamicPart("id", """[^/]+""",true)))
  )
  private[this] lazy val controllers_ReminderController_resetReminder8_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      ReminderController_2.resetReminder(fakeValue[play.mvc.Http.Request], fakeValue[Long]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.ReminderController",
      "resetReminder",
      Seq(classOf[play.mvc.Http.Request], classOf[Long]),
      "PATCH",
      this.prefix + """reminders/reset/""" + "$" + """id<[^/]+>""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:27
  private[this] lazy val controllers_ReminderController_getRemindersSorted9_route = Route("GET",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("reminders/sortedall")))
  )
  private[this] lazy val controllers_ReminderController_getRemindersSorted9_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      ReminderController_2.getRemindersSorted(fakeValue[play.mvc.Http.Request]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.ReminderController",
      "getRemindersSorted",
      Seq(classOf[play.mvc.Http.Request]),
      "GET",
      this.prefix + """reminders/sortedall""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:29
  private[this] lazy val controllers_ReminderController_deleteReminder10_route = Route("DELETE",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("reminders/"), DynamicPart("id", """[^/]+""",true)))
  )
  private[this] lazy val controllers_ReminderController_deleteReminder10_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      ReminderController_2.deleteReminder(fakeValue[play.mvc.Http.Request], fakeValue[Long]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.ReminderController",
      "deleteReminder",
      Seq(classOf[play.mvc.Http.Request], classOf[Long]),
      "DELETE",
      this.prefix + """reminders/""" + "$" + """id<[^/]+>""",
      """""",
      Seq("""nocsrf""")
    )
  )

  // @LINE:31
  private[this] lazy val controllers_ReminderController_getRemindersByCar11_route = Route("GET",
    PathPattern(List(StaticPart(this.prefix), StaticPart(this.defaultPrefix), StaticPart("reminders/"), DynamicPart("carID", """[^/]+""",true)))
  )
  private[this] lazy val controllers_ReminderController_getRemindersByCar11_invoker = createInvoker(
    
    (req:play.mvc.Http.Request) =>
      ReminderController_2.getRemindersByCar(fakeValue[play.mvc.Http.Request], fakeValue[Long]),
    play.api.routing.HandlerDef(this.getClass.getClassLoader,
      "router",
      "controllers.ReminderController",
      "getRemindersByCar",
      Seq(classOf[play.mvc.Http.Request], classOf[Long]),
      "GET",
      this.prefix + """reminders/""" + "$" + """carID<[^/]+>""",
      """""",
      Seq("""nocsrf""")
    )
  )


  def routes: PartialFunction[RequestHeader, Handler] = {
  
    // @LINE:6
    case controllers_UserController_signUp0_route(params@_) =>
      call { 
        controllers_UserController_signUp0_invoker.call(
          req => UserController_0.signUp(req))
      }
  
    // @LINE:7
    case controllers_UserController_logIn1_route(params@_) =>
      call { 
        controllers_UserController_logIn1_invoker.call(
          req => UserController_0.logIn(req))
      }
  
    // @LINE:9
    case controllers_UserController_isAuthenticated2_route(params@_) =>
      call { 
        controllers_UserController_isAuthenticated2_invoker.call(
          req => UserController_0.isAuthenticated(req))
      }
  
    // @LINE:11
    case controllers_UserController_getUserName3_route(params@_) =>
      call { 
        controllers_UserController_getUserName3_invoker.call(
          req => UserController_0.getUserName(req))
      }
  
    // @LINE:15
    case controllers_CarController_add4_route(params@_) =>
      call { 
        controllers_CarController_add4_invoker.call(
          req => CarController_1.add(req))
      }
  
    // @LINE:17
    case controllers_CarController_getCarsByUser5_route(params@_) =>
      call { 
        controllers_CarController_getCarsByUser5_invoker.call(
          req => CarController_1.getCarsByUser(req))
      }
  
    // @LINE:19
    case controllers_CarController_deleteCar6_route(params@_) =>
      call(params.fromPath[Long]("id", None)) { (id) =>
        controllers_CarController_deleteCar6_invoker.call(
          req => CarController_1.deleteCar(req, id))
      }
  
    // @LINE:23
    case controllers_ReminderController_addReminder7_route(params@_) =>
      call(params.fromPath[Long]("carID", None)) { (carID) =>
        controllers_ReminderController_addReminder7_invoker.call(
          req => ReminderController_2.addReminder(req, carID))
      }
  
    // @LINE:25
    case controllers_ReminderController_resetReminder8_route(params@_) =>
      call(params.fromPath[Long]("id", None)) { (id) =>
        controllers_ReminderController_resetReminder8_invoker.call(
          req => ReminderController_2.resetReminder(req, id))
      }
  
    // @LINE:27
    case controllers_ReminderController_getRemindersSorted9_route(params@_) =>
      call { 
        controllers_ReminderController_getRemindersSorted9_invoker.call(
          req => ReminderController_2.getRemindersSorted(req))
      }
  
    // @LINE:29
    case controllers_ReminderController_deleteReminder10_route(params@_) =>
      call(params.fromPath[Long]("id", None)) { (id) =>
        controllers_ReminderController_deleteReminder10_invoker.call(
          req => ReminderController_2.deleteReminder(req, id))
      }
  
    // @LINE:31
    case controllers_ReminderController_getRemindersByCar11_route(params@_) =>
      call(params.fromPath[Long]("carID", None)) { (carID) =>
        controllers_ReminderController_getRemindersByCar11_invoker.call(
          req => ReminderController_2.getRemindersByCar(req, carID))
      }
  }
}
