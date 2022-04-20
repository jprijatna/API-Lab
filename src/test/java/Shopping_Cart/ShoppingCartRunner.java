package Shopping_Cart;

import com.intuit.karate.junit5.Karate;

public class ShoppingCartRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("shopping_cart").relativeTo(getClass());
    }
}
