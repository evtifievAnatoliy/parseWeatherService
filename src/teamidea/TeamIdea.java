package teamidea;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class TeamIdea {
    
    public static void main(String[] args){
        
        String url = "http://api.openweathermap.org/data/2.5/forecast?q=Saint%20Petersburg,%20RU&mode=json&appid=7ad6640f2d4b76480afbe652df3a7efa";
        
        try{
            
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
 
            con.setRequestMethod("GET");
 
            BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
 
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            
            //----------------------------------------------
            
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject) jsonParser.parse(response.toString());
 
            String town = parseJsonObject(jsonObject, "city", "name");
            
            System.out.println("Прогноз погоды в городе: " + town + " на 5-ть дней:");
 
            JSONArray jsonList= (JSONArray) jsonObject.get("list");
            ArrayList <TemperatureDate> temperatureDays= new ArrayList<TemperatureDate>();
            
            Iterator i = jsonList.iterator();
            String lastDateStr = "first";
            TemperatureDate temperatureDate = new TemperatureDate();
            while (i.hasNext()) {
                JSONObject innerObj = (JSONObject) i.next();
                String localDate = (String) innerObj.get("dt_txt");
                String[] timeArray = localDate.split(" ");
                
                if(!lastDateStr.equals(timeArray[0])){
                    if (lastDateStr.equals("first"))
                        temperatureDate.setLocalDate(LocalDate.parse(timeArray[0]));
                    else
                        temperatureDate = new TemperatureDate(LocalDate.parse(timeArray[0]));
                    temperatureDays.add(temperatureDate);
                }
                LocalTime time = LocalTime.parse(timeArray[1]);
                String tempMin = parseJsonObject(innerObj, "main", "temp_min");
                String tempMax = parseJsonObject(innerObj, "main", "temp_max");
                temperatureDate.addTemperatureTime(new TemperatureTime(time, Float.parseFloat(tempMin), Float.parseFloat(tempMax)));
                lastDateStr = timeArray[0];
            }
            
            showWeather(temperatureDays);
        }
        catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }
    
    private static String parseJsonObject(JSONObject object, String objectName, String innerName){
        JSONObject jsonObject= (JSONObject) object.get(objectName);
        return (String) jsonObject.get(innerName).toString();
    }
    
    private static void showWeather (ArrayList<TemperatureDate> arrayList){
        for (TemperatureDate date: arrayList)
            System.out.println(date.toString());
    }
    
}
