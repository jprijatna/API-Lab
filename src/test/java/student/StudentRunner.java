package student;

import com.intuit.karate.junit5.Karate;

//public class StudentRunner {
//    @Karate.Test
//    Karate testUsers() {return Karate.run("student_token").relativeTo(getClass());}
//}
//public class StudentRunner {
//    @Karate.Test
//    Karate testUsers() {return Karate.run("student_token").relativeTo(getClass());}
//}
public class StudentRunner {
    @Karate.Test
    Karate testUsers() {return Karate.run("student_token", "student_create", "student_details").relativeTo(getClass());}
}