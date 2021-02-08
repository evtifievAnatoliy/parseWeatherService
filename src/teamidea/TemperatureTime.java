package teamidea;

import java.time.LocalTime;

public class TemperatureTime {
    private LocalTime localTime;
    private float tempMin;
    private float tempMax;
    private float tempMed;

    public TemperatureTime(LocalTime localTime, float tempMin, float tempMax) {
        this.localTime = localTime;
        this.tempMin = (float) (tempMin - 273.15);
        this.tempMax = (float) (tempMax - 273.15);
        this.tempMed = (this.tempMax+this.tempMin)/2;
    }

    public float getMediumTemp() {
        return tempMed;
    }

    public LocalTime getLocalTime() {
        return localTime;
    }

    public float getTempMax() {
        return tempMax;
    }

}
