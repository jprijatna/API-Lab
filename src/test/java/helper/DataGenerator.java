package helper;

import com.github.javafaker.Faker;
//import java.util.Locale;

public class DataGenerator {
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }
}