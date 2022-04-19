package vehicle;

import com.intuit.karate.junit5.Karate;

public class VehicleRunner {
    @Karate.Test
    Karate testUsers(){
        return Karate.run("vehicle_details").relativeTo(getClass());
    }
}