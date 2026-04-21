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