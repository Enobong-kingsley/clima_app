import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


void main(){
  performTasks();
}

void performTasks() {
  task1();
  task2();
  task3();
}

void task1 (){
  String result = "task 1 data";
  print("Task 1 complete");

}
void task2 (){
  Duration threeSeconds = Duration(seconds: 3);
  Future.delayed(threeSeconds,(){
     String result = "task 2 data";
     print("Task 2 complete");
  });
 
}
void task3 (){
  String result = "task 3 data";
  print("Task 3 complete");

}

 void getData() async{
   http.Response response = await http.get(Uri.parse('http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1'));
   print("printing the response : $response");
   

   if(response.statusCode == 200){
    String data = response.body;
     print("printing the response body : $data");

     var longitude = jsonDecode(data)["coord"]["lon"];
     print(longitude);

     var weatherDescription = jsonDecode(data)["weather"][0]["description"];
     var weatherId = jsonDecode(data)["weather"][0]["id"];
     print("${weatherDescription}, ${weatherId}");

     var baseLoc = jsonDecode(data)["base"];
     print(baseLoc);

     var nameLoc = jsonDecode(data)["name"];
     print(nameLoc);

     var idLoc = jsonDecode(data)["id"];
     print(idLoc);

   }else{
    print("printing the response status code : ${response.statusCode}");
   }
  }
