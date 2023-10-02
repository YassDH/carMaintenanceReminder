# My Car Maintenance Reminder


## Table of Contents  
-  [Introduction](#introduction) 
-  [Features](#features) 
-  [Technologies Used](#technologies-used) 
-  [Installation](#installation) 
-  [API](#api) 
-  [Screenshots](#screenshots) 
-  [Conclusion](#conclusion)
## Introduction 
During my summer internship, I had the incredible opportunity to develop a mobile app for iOS aimed at simplifying the technical maintenance tracking of personal vehicles. This project represents the culmination of my internship experience, where I had the chance to apply my skills, learn new technologies, and contribute to a real-world application.
## Features
Key features of this app include :
- Authentication (Login / Signup).
-  Detailed record-keeping of maintenance and repairs. 
-  Automated scheduling and reminders for upcoming service tasks. 
- Real-time monitoring of vehicle health and performance. 
- Access to historical maintenance data. 
- Seamless integration with REST services for accurate and up-to-date information.
## Technologies Used
- [Swift](https://www.apple.com/uk/swift/) for app development
- [Play Framework](https://www.playframework.com/) for backend (using JAVA)
- [JSON Web Tokens](https://jwt.io/) for authentification 
- [MySQL](https://www.mysql.com/fr/) as a Database
- [GitHub](https://github.com/) for version control
## Installation
To run this app locally, follow these steps: 
1. Clone the repository. 
2. Create an SQL database (using [XAMPP](https://www.apachefriends.org/index.html) for example).
3. Import the [SQL](https://github.com/YassDH/carMaintenanceReminder/tree/main/DB) file to the created Database.
4. Go to the `./Back/conf/application.conf` file and set your database credentials as follow : 
```sh
db.default.url="jdbc:mysql://localhost/{YOUR_DATABSE_NAME}"
db.default.username="{SQL_USER}" // exp : "root"
db.default.password="{SQL_PASSWORD}" // exp : ""
```
5. To run the Backend you juste have to type in the Terminal `sbt run`.
> Warning: JAVA [8](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html) or [11](https://www.oracle.com/java/technologies/javase/jdk11-archive-downloads.html) is required to run the app.
6. The App should be running on `PORT 9000` ([http://localhost:9000](http://localhost:9000/)).
7. To test the Backend just try any of the [API](https://github.com/YassDH/carMaintenanceReminder/tree/main/API) endpoints using a tool like [Postman](https://www.postman.com/).
8. Now you only have to build and run the Frontend on [Xcode](https://developer.apple.com/xcode/).
## API
|        Endpoint       | Method |                                         Description                                        |
|:---------------------|:------:|:------------------------------------------------------------------------------------------|
| /user/login           |  POST  | Authenticate the user and returns a JWT token                                              |
| /user/register        |  POST  | Adds new user to the database and rturns  a JWT token                                      |
| /user/verify          |   GET  | Verify if the user is authenticated                                                        |
| /cars/add             |  POST  | Adds a car to the database                                                                 |
| /cars                 |   GET  | Returns user's cars                                                                        |
| /cars/:id             | DELETE | Deletes the car with the id "id"                                                           |
| /reminders/add/:carID |  POST  | Adds a reminder to the car with id "id"                                                    |
| /reminders/:id        | DELETE | Deletes the reminder with the id "id"                                                      |
| /reminders/reset/:id  |  PATCH | Updates the reminder with the id "id"                                                      |
| /reminders/:carID     |   GET  | Gets all the reminders of the car with the id "id"                                         |
| /reminders/sortedall  |   GET  | Retrieve the reminders of the authenticated user sorted chronologically by expiration date |
## Screenshots

| | | |
:-------------------------:|:-------------------------:|:-------------------------:
|Home| Login | Signup|
| ![Home](/Screenshots/Accueil.png) | ![Login](/Screenshots/Connexion.png) | ![Signup](/Screenshots/Inscription.png)
|Reminders Preview| My Cars| Add Car|
| ![Reminders Preview](/Screenshots/AprecuRappel.png) | ![My Cars](/Screenshots/MonGarage.png) | ![Add Car](/Screenshots/AjoutVoiture.png)
|Add Reminder| | |
| ![Add Reminder](/Screenshots/AjoutRappel.png) | |

## Conclusion

My summer internship was an incredible learning experience, and I'm proud of the app I've developed. I hope it proves to be a valuable tool for professionals managing their tasks.

New features can be added to the application in future updates. For example, it would be possible to offer customers the option to connect their vehicle's "GPS Tracker" to the application, allowing for detailed tracking of the number of kilometers traveled by their vehicle, making reminders even more precise and useful.
