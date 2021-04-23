# MoMaps

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This application allows the user to navigate to any location. You can save favorite locations and future locations to visit. User is able to incorporate saved location into navigation mode.

### App Evaluation

- **Category:** GPS/ City Navigation
- **Mobile:** This app would be developed primarily for mobile - as the step-by-step navigation feature of the app would require the user to navigate through their city using their phone to get to their favorite spots!
- **Story:** Allow users to save future locations they want to visit and add favorites to the locations they’ve already visited. To make ease of access - once a favorite spot is added, the imbedded step-by-step navigation feature will allow users to directly get to that location with the latest traffic information.
- **Market:** This app caters to users who prefer to drive and explore their city! With our real-time traffic information, users are able to get the safest routes to their desired destinations!
- **Habit:** This app could be used as often as the user has the desire to explore their city. Whether it be from going out to their favorite restaurants with their loved ones, to even to a cool park they found and saved on their way back from work!
- **Scope:** First users will have the ability to add their favorite locations and any locations they want to visit for future references on the app. Once they’re on their favorite lists they can directly click on one of the spots - and the app will automatically launch its step-by-step navigation directions and take users to their desired locations!

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login/ sign up for user
* Ask for permission for user’s location to automate gps tracking
* Provide a general map according to the user’s location on home page 
* Implement a tab bar with 4 categories: search for new location, user's favorite sites, user's plan to visit sites and save new location.
* Implement a search bar for any address 
* Implement a “go” button to navigate
* highlight the best possible route to your location

**Optional Nice-to-have Stories**

* Real time traffic conditions
* Should show surrounding well known locations in map  
* Be able to manipulate map with gestures
* Dark mode/ light mode 


### 2. Screen Archetypes

* Login/ sign up
   * User is prompted to input username and password
   * Login if password is correct, unable login if password is wrong
   * button for sign up, signs the user to the password chosen 

* Home
   * General map of user's current location 
   * Tab bar is available to add new location, favorite locations and locations to visit 
   * search bar is available to search any address to navigate
* favorites
   * List of your favorite locations with associated name, description and address  
* Add
   * User is able to add a location and save it's name, description and address. This location can be a location inside plan to visit tab or favorite location tab.
* Places to visit 
   * List of your locations you plan to visit with  associated name, description and address 
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search
* Places to visit
* Favorites
* Add Favorites

**Flow Navigation** (Screen to Screen)

* Login in/sign up  -> home screen (search tab)
* Search Tab-> search address -> map will zoom into that location 
   * step-by-step navigation feature will be enabled -> ability to add that location to favorites
* Places Tab -> scroll through the places user wants to visit 
   * click on a place and navigate to that place through the step-by-step navigation feature
* Favorites Tab -> scroll through the places user has favorited 
   * click on a place and navigate to that place through the step-by-step navigation feature
* Add Favorites Tab -> users will add places for future visits or any favorite places they’ve visited already.


## Wireframes
![](https://i.imgur.com/ycQfqfH.jpg)

### [BONUS] Digital Wireframes & Mockups
![](https://i.imgur.com/6GhVKOF.jpg)
### [BONUS] Interactive Prototype

## Schema 

#### Users:

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | username      | String   |  The name the user picks for their account |
   | password      | String   |  The password linked to specific username|
   | location_list | array of location object | List of location coordinates inside an array of dictionaries |
 
#### Location Object(where we store locations saved by users):

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | coordinates      | pair<float,float>   |  Pair of longitude and latitude float numbers|
   | Favorite/Plan    | Char   |  If the location contains an “F” its a favorite, if it contains a “P” its planned to visit|
   | Description | string | Users can add a description to the specific location |
   
#### Map Object:

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | location_pin      | Location object   | Pin is dropped at location selected by user|
   | user_pin      | pair<float, float>   |  Pin is dropped at user’s current location |

 
  

### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
