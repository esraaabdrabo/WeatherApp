# **SOLID Principles Refactoring Project**
This repository is a fork of an existing project that contains multiple violations of the SOLID principles. The goal of this project is to identify these issues, document them, and refactor the necessary parts to improve the overall design and maintainability of the code.

## **Objectives**
- Analyze the codebase and highlight violations of SOLID principles.
- Provide detailed explanations for each issue, linking them to specific principles.
- Implement refactoring techniques to improve code quality while preserving functionality.
- Apply relevant design patterns where needed to enhance scalability and maintainability.

### **Old Design**  
- **Hardcoded API Paths**: API endpoints were manually constructed inside methods, violating SRP and OCP.  
- **Query Parameters Duplication**: Each API call manually handled query parameters, violating DRY.  
- **Mixed Responsibilities in `getWeather()`**: The method was responsible for both making requests and parsing JSON, violating SRP.  
- **Mutable Model Fields**: Weather data fields were mutable, increasing risk of unintended modifications.  
- **UI Logic in Model**: The model contained UI-related color logic, violating SRP and leading to tight coupling.  
- **Date Parsing in Model**: Date formatting was handled inside the model instead of a utility class, reducing reusability.  

### **New Design**  
- **Centralized API Endpoints**: API paths are now stored in `ApiEndpoints`, making maintenance easier.  
- **Encapsulated Query Parameters**: `WeatherServiceQueries` handles query parameters, improving extensibility.  
- **Separated HTTP Client**: `HttpClient` manages requests, while `WeatherService` focuses only on fetching weather data.  
- **Immutable Model**: `final` fields ensure the weather data remains unchanged after instantiation.  
- **Moved UI Logic to UI Layer**: Colors are now managed separately, preventing tight coupling with the model.  
- **Utilized `DateTimeHelper`**: Date parsing is now handled via a helper class for consistency.  

