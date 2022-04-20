package vehicle;

import com.intuit.karate.junit5.Karate;

public class VehicleRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("vehicle_details", "vehicle_source", "data_mapping").relativeTo(getClass());
    }
}