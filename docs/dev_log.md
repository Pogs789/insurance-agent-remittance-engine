# Development Log

## [04-20-2026] - Implementation of the Authentication Feature for Both Frontend and Backend
**Context:**
Working on the data flow for authenticating the user from the Flutter App.

**The Challenge:**
* How would I store the session data needed to constatnly check if the user is still authenticated using userId and refreshTokens.

**The Solution:**
* For refreshToken and logout in Flutter, I integrate the local data source into the remote datasource where I simply send the data to the backend, which it verifies it, but thats another thing to be tested tomorrow.

**Key References:**
* This is a solved problem on my own.

---

## [05-02-2026] - Solved a problem when it comes to module exports
**Context:**
Working on the data flow for authenticating the user from the Flutter App.

**The Challenge:**
* How would I store the session data needed to constatnly check if the user is still authenticated using userId and refreshTokens.

**The Solution:**
* For refreshToken and logout in Flutter, I integrate the local data source into the remote datasource where I simply send the data to the backend, which it verifies it, but thats another thing to be tested tomorrow.

## [05-15-2026] - Choosing between finishing the application as a custom software to be sold to Insurance Companies, or as a standalone Service for Insurance Agents.
**Context:**
Mapping out how would the insurance app would look like when it was finished.

**The Challenge:**
* What type of insurance app should I build? A Custom Software or a Standalone Service (where Insurance Companies register to the system, along with Insurance Agents)? This determines how would my application would look like.

**The Solution:**
* I choose the Standalone Service because of its speed, urgency as well as giving Insurance Companies a way to use our system.

## [05-19-2026] - Fixing the update error in Android Studio
**Context:**
Updating to latest Android Studio Version.

**The Challenge:**
* When I update my Android Studio into the latest release, I encountered a problem, which is Dart, in order to function, requires a plugin called com.redhat.devtools.lsp4ij in order for my project in mobile to continue. 
* In addition, I encountered a problem when it comes to gradle, which wrongfully identifies my lib folder as its build.

**The Solution:**
* I simply installed the LSP4IJ Plugin in my Android Studio to support Dart, which in turn support Flutter. This also restarts my IDE.
* I change my directory to its correct one, which is Android, which exposes another problem when it comes to JAVA_HOME env, which I setted it. Then I initialied my gradle plugin.

**Reference:**
* https://www.reddit.com/r/flutterhelp/comments/1t4ry8x/comredhatdevtoolslsp4ij_plugin_required_by_new/