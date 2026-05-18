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