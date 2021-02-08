package teamidea;

import java.time.LocalDate;
import java.util.ArrayList;

public class TemperatureDate {
    
    LocalDate localDate;
    ArrayList <TemperatureTime> temperatureTimes;

    public TemperatureDate() {
        temperatureTimes = new ArrayList<TemperatureTime>();
    }
    
    public TemperatureDate(LocalDate localDate) {
        this();
        this.localDate = localDate;
    }

    public void setLocalDate(LocalDate localDate) {
        this.localDate = localDate;
    }
    
    public void addTemperatureTime(TemperatureTime temperatureTime){
        temperatureTimes.add(temperatureTime);
    }
    
    public float getMediumTemperature(ArrayList<TemperatureTime> arrayList){
        float mediumSum = 0;
        for (TemperatureTime temperatureTime: arrayList){
            mediumSum += temperatureTime.getMediumTemp();
        }
        return mediumSum/arrayList.size();
    }
    
    public String getMaxMorningTemperature(ArrayList<TemperatureTime> arrayList){
        float maxMornTemp = -99999;
        for (TemperatureTime temperatureTime: arrayList){
            if (temperatureTime.getLocalTime().getHour()<12 && temperatureTime.getLocalTime().getHour()>5)
                if (maxMornTemp < temperatureTime.getTempMax())
                    maxMornTemp = temperatureTime.getTempMax();
        }
        if (maxMornTemp == -99999){
            return "There is no such data";
        }
        return String.valueOf(maxMornTemp);
    }
    
    @Override
    public String toString() {
        return "TemperatureDate{" + "localDate=" + localDate + " MediumTemperature=" + getMediumTemperature(temperatureTimes) +  " MinMorningTemperature=" + getMaxMorningTemperature(temperatureTimes) +'}';
    }
    
}
