# Seven Springs Accident Reporting Application
This repository contains code for a mobile device app which skiiers and snowboarders can use at Seven Springs Mountain Resort to report accidents and injuries on the slopes. Users may fill out an accident report form or call the ski patrol phone number to recieve the quickest care possible. 
## Intentions
This application intends to help ski patrollers at Seven Springs be alerted of accidents more quickly and efficiently than the current system.  Currently, someone must alert a lift attendant at the top of bottom to report an accident to  ski patrol, which can take time especially for long lifts. A user making a report via the app will get useful information to ski patrol more quickly than waiting to get off of the lift or to the bottom of the slope. This can ultimately save lives when serious accidents occur.
## Main Page
When users open the application, they will see the options to either make a accident report or call the ski patrol directly. The main screen of the application is shown in the image below.

![Main Page](Images/main-page.jpg)
## Report Form
Users are able to provide information in the report such as the trail the accident is on, the exact location on that trail, and details about the condition of the victim.  Once the user submits the report, the application communicates the information in the form to an AWS server. The dispatcher from the main ski patrol lodge will see the accident show up on the server and dispatch the proper personel to the accident site.

The form is depicted in the figure below:

![Report Form](Images/report-form.jpg)

## Call Button
If the user chooses to call rather that fill out a report, the application will dial the ski patrol with one button. This is useful in the case that the user's hands may be too cold to fill out a form and they would rather talk to someone. It is also useful if the server is off for any reason and a user would like to report an accident. The call functionality is depicted in the image below.

![Call Page](Images/call-button.jpg)
## Trail Map
If the User needs a visual to find out which slope they are on, the trail map button (from the main screen) will provide a visual for them. This will also result in less errors in reporting incorrect slopes to ski patrollers.

![Trail Map](elevator-generator/trail-map.jpg)

## History of the Project
1. Made an initial pitch in Pitt's NGCMP 0600 class to form a team.
2. Started a trello kanban board to manage tasks for the group members.
3. Created a wireframe of the app to create the initial design.
4. Made a pitch to the professor with the intial design.
5. Started Xcode project to write the app.
6. Wrote server-side code to capture accident reports from the iOS application. 
7. Created LICENSE and README files.
8. Started coding a website for non-apple users to use the service.

## Goals
* Currently this application is only compatable with iOS.  We wish to create a similar form on a website to accomidate android and other users.
* We plan to help Seven Springs Ski Patrol implement this project for use starting Winter 2020.

## Team
>Andrew Toader 
>Tyler Comisky
>Nick Latiolais
>Jason Weger

## [License](https://github.com/aet37/Ski-Patrol-App/blob/main/LICENSE.md)

Project URL: https://github.com/aet37/Ski-Patrol-App

Copyright (c) 2020 [Andrew Toader](https://github.com/aet37)

All Rights Reserved. This website or any portion thereof may not be reproduced, distributed, or transmitted in any form without permission from the publisher. 

The above copyright notice shall be included in all copies or substantial portions of the software.
