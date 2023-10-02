name := """play-java-hello-world-tutorial"""
organization := "com.example"

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

scalaVersion := "2.13.10"

libraryDependencies += guice
libraryDependencies += ws
libraryDependencies ++= Seq(
  javaJdbc
)

libraryDependencies ++= Seq("mysql" % "mysql-connector-java" % "5.1.41")
libraryDependencies += "com.auth0" % "java-jwt" % "3.3.0"
libraryDependencies += "org.mindrot" % "jbcrypt" % "0.4"
