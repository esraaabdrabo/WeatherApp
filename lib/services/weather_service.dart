import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/api_endpoints.dart';
import 'package:weather_app/services/app_error_handler.dart';
import 'package:weather_app/services/app_exception.dart';
import 'package:weather_app/services/http_client.dart';
import 'package:weather_app/services/weather_service_queries.dart';

class WeatherService {
  WeatherService._();
  static final WeatherService _instance = WeatherService._();
  static WeatherService get instance => _instance;
  final HttpClient _client = HttpClient.instance;

  Future<WeatherModel?> getWeather({
    required WeatherServiceQueries quires,
  }) async {
    final WeatherModel? weather;
    Response? response;
    try {
//
// instead of the following code we created WeatherServiceQueries class to handle the query parameters.
/** final Uri url = Uri.parse(ApiEndpoints.forecast).replace(
        queryParameters: {
          'key': apiKey,
          'q': cityName,
          'days': '5',
          'aqi': 'no',
          'alerts': 'no',
        },
      );
 */
//Hardcoding query parameters increases
// the risk of introducing bugs due to typos or missing values.
//
// The query parameters are now handled by WeatherServiceQueries, making the code
// more readable and maintainable.
//
// Additionally, embedding query construction here violates the Single Responsibility
// Principle (SRP), as this method should only be responsible for fetching data,
// not constructing the query parameters.
/**
### **🔴 1. OCP (Open/Closed Principle) Violation**  
**OCP states that a class should be open for extension but closed for modification.**  
Your original hardcoded approach **violates this** because:

- If the API provider **adds new query parameters**, you must **modify existing code** inside `getWeather()`, which breaks OCP.
- If a different API endpoint (e.g., `getWeatherHistory`) has a **slightly different set of parameters**, you might end up duplicating query construction logic.

---

### **🔴 2. DRY (Don't Repeat Yourself) Violation**  
**DRY principle states that code should not be duplicated unnecessarily.**  
In the original version, **each API method** manually constructs query parameters like this:
```dart
queryParameters: {
  'key': apiKey,
  'q': cityName,
  'days': '5',
  'aqi': 'no',
  'alerts': 'no',
}
This means:  
✔ If you have multiple API calls with similar queries, **you repeat this code**.  
✔ If a parameter name changes (e.g., `q` → `location`), **you must update all occurrences manually**.  

 */

      response = await _client.get(
        ApiEndpoints.forecast,
        queryParameters: quires.toJson(),
      );
      if (response.statusCode != 200) {
        final AppException? exception =
            AppErrorHandler.handle(response: response);
        if (exception != null) {
          throw exception;
        }
      }
      weather = WeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw AppErrorHandler.handle(exception: e)!;
    }

    return weather;
  }

  //This will return error message since the history api is not free.
  Future<WeatherModel?> getWeatherHistory({
    required WeatherServiceQueries quires,
  }) async {
    final WeatherModel? weather;
    Response? response;
    try {
      response = await _client.get(
        ApiEndpoints.history,
        queryParameters: quires.toJson(),
      );
      if (response.statusCode != 200) {
        final AppException? exception =
            AppErrorHandler.handle(response: response);
        if (exception != null) {
          throw exception;
        }
      }
      weather = WeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw AppErrorHandler.handle(exception: e)!;
    }
    return weather;
  }
}

///You're asking about whether hardcoding the path as a string in your method violates SOLID.
/**
## **Does Hardcoding the API Path Violate SOLID?**
Yes, **hardcoding the path as a string** like this:
```dart
final Uri url = Uri.parse('$_baseUrl/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no');
```
**can violate SOLID principles**—mainly **SRP (Single Responsibility Principle)** and **OCP (Open/Closed Principle)**.

---

## **🔴 SRP (Single Responsibility Principle) Violation**
### **Why is this a problem?**
- The method **mixes two responsibilities**:
  1. **Defining API endpoints** (which should ideally be stored centrally).
  2. **Handling API requests**.

- If tomorrow, the API changes from:/forecast.json to: /weather/forecast
  **You will need to modify every place where this path is used**, increasing the chances of introducing bugs.

If the API structure changes, you must modify every method where the path is hardcoded.
Mixing API path definition with API call logic makes it harder to maintain.
If multiple methods repeat similar paths, there is duplication, making code updates risky.

### **✅ How to Fix This?**
Store API paths **as constants** in a separate file:
```dart
class ApiEndpoints {
  static const String forecast = '/forecast.json';
  static const String history = '/history.json';
}
```
Then, update your code to:
```dart
final Uri url = Uri.parse('$_baseUrl${ApiEndpoints.forecast}').replace(queryParameters: {
  'key': apiKey,
  'q': cityName,
  'days': '5',
  'aqi': 'no',
  'alerts': 'no',
});
```
### **🔹 Benefits:**
✔ **Easier maintenance** – Changing paths in one place updates all usages.  
✔ **Clearer structure** – API paths are now **centralized** instead of scattered throughout your code.  
SRP is violated because defining API paths should not be mixed with fetching and processing data.

By extracting API paths into a separate class, you ensure that each component has a single responsibility,
 making the code easier to maintain and extend. 🚀
---

## **🔴 OCP (Open/Closed Principle) Violation**
### **Why is this a problem?**
- If you need to support **multiple API versions** (e.g., `v1`, `v2`), hardcoded paths force **modifications in multiple places**.

**Example problem:**
```dart
final Uri url = Uri.parse('http://api.weatherapi.com/v1/forecast.json');
```
- If the API upgrades to **v2**, you must **update every occurrence** of `v1`.

### **✅ How to Fix This?**
Use a **dynamic versioning system**:
```dart
class ApiConfig {
  static const String version = 'v1';
  static const String baseUrl = 'http://api.weatherapi.com/$version';
}

final Uri url = Uri.parse('${ApiConfig.baseUrl}${ApiEndpoints.forecast}').replace(queryParameters: {
  'key': apiKey,
  'q': cityName,
  'days': '5',
  'aqi': 'no',
  'alerts': 'no',
});
```
### **🔹 Benefits:**
✔ **New API versions require minimal changes** – just update `ApiConfig.version`.  
✔ **More flexible** – Easy to switch between different versions without modifying core logic.  

---

## **🚀 Final Thoughts**
Hardcoding paths as strings **doesn't immediately break SOLID**, but:
- **SRP is violated** because paths are defined in multiple places instead of a centralized config.  
- **OCP is violated** because any change to API paths **requires modifying existing code instead of just extending it**.  

✅ **Solution:**  
- Use **a constants file (`ApiEndpoints`) for paths**.  
- Use **`ApiConfig` to handle versioning and the base URL**.  
- Construct URIs dynamically using **`replace(queryParameters: {...})`**.  
---


class _WeatherService {
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      //Todo this method is doing more than one job so it's violating the single responsibility principle, since it's responsible for
      // fetching the data and parsing it, so we need to separate the logic by creating http client which is responsible for requests only and return AppHttpResponse only then the parsing will be done her.
      String baseUrl = 'http://api.weatherapi.com/v1';
      String apiKey = '';
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=5&aqi=no&alerts=no');
      // need clinet.
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = WeatherModel.fromJson(data);
    } catch (e) {
      // the user has no idea what is the problem we need to show a message to the user.
      print(e);
    }
    return weather;
  }
}
 */
