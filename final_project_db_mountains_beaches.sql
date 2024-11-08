CREATE TABLE Users ( UserID INTEGER PRIMARY KEY AUTOINCREMENT, Age INTEGER, Gender TEXT, Income INTEGER, Education_Level TEXT, Travel_Frequency INTEGER, Vacation_Budget INTEGER, Location TEXT, Favorite_Season TEXT, Pets INTEGER, Environmental_Concerns INTEGER )
CREATE TABLE Preferences ( PreferenceID INTEGER PRIMARY KEY AUTOINCREMENT, UserID INTEGER, Preferred_Activities TEXT, Proximity_to_Mountains INTEGER, Proximity_to_Beaches INTEGER, Preference INTEGER, FOREIGN KEY (UserID) REFERENCES Users(UserID) );

SELECT * FROM Users u LIMIT 5

SELECT * FROM Preferences p LIMIT 5
--Retrieving the first 5 records from the users and preferences tables--

SELECT Preferences.UserID FROM Preferences LEFT 
JOIN Users 
ON Preferences.UserID = Users.UserID 
WHERE Users.UserID IS NULL
--identifies entries in the users table where the UserID does not exist in the Users Table--

SELECT Preferred_Activities, COUNT(*) AS ActivityCount 
FROM Preferences 
WHERE Preference = 1 
GROUP BY Preferred_Activities
ORDER BY ActivityCount DESC 
LIMIT 3
--Count the number of times each activity is marked as preferred as well as listing the top two most preferred activities--

SELECT Preferences.Preference, AVG(Users.Vacation_Budget) AS AvgBudget
FROM Users
JOIN Preferences
ON Users.UserID = Preferences.UserID
GROUP BY Preferences.Preference
--Meant to find the average vacation budget for users--

SELECT Preferred_Activities, SUM(CASE WHEN Preference = 1 THEN 1 ELSE 0 END) AS PreferredCount, SUM(CASE WHEN Preference = 0 THEN 1 ELSE 0 END) AS NotPreferredCount 
FROM Preferences 
GROUP BY Preferred_Activities;
--Counts how many users prefer or not prefer each activity--

SELECT Users.Location, AVG(Preferences.Proximity_to_Mountains) AS AvgMountainProximity, AVG(Preferences.Proximity_to_Beaches) AS AvgBeachProximity
FROM Users
JOIN Preferences
ON Users.UserID = Preferences.UserID
GROUP BY Users.Location
--This isw was meant to calculate average proximity to mountains or beaches based on location--

SELECT Preferred_Activities, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Users)) AS PreferencePercentage 
FROM Preferences
WHERE Preference = 1 
GROUP BY Preferred_Activities 
ORDER BY PreferencePercentage DESC;
--Calculate the percent of users who prefer the top activities--