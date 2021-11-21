import 'package:http/http.dart' as http;
import 'dart:convert';

class Internet {
  static fetchApiKey() async {
    http.Response response = await http.get(
        Uri.parse("https://todoapp-api-pyq5q.ondigitalocean.app/register"));

    var responseObject = response.body;
    return responseObject;
  }

  static performGetRequest(apiKey) async {
    http.Response response = await http.get(Uri.parse(
        "https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$apiKey"));

    return jsonDecode(response.body);
  }

  static performPostRequest(textInputValue, apiKey) async {
    http.Response response = await http.post(
        Uri.parse(
            "https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": "$textInputValue", "done": false}));

    return jsonDecode(response.body);
  }

  static performPutRequest(
      textField, checkValue, taskToBeRemovedUpdated, apiKey) async {
    http.Response response = await http.put(
        Uri.parse(
            "https://todoapp-api-pyq5q.ondigitalocean.app/todos/$taskToBeRemovedUpdated?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": textField, "done": checkValue}));

    return jsonDecode(response.body);
  }

  static performDeleteRequest(taskToBeRemovedID, apiKey) async {
    http.Response response = await http.delete(Uri.parse(
        "https://todoapp-api-pyq5q.ondigitalocean.app/todos/$taskToBeRemovedID?key=$apiKey"));

    return jsonDecode(response.body);
  }
}
