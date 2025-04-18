package org.example.db;

import java.sql.Connection;
import java.sql.SQLException;
import io.github.cdimascio.dotenv.Dotenv;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// establish a connection to the database
@Configuration
public class TestConnect {
    static Dotenv dotenv = Dotenv.load();
    private final static String url = dotenv.get("DB_URL");
    private final static String user = dotenv.get("DB_USER");
    private final static String password = dotenv.get("DB_PASS");
    private static final BasicDataSource ds = new BasicDataSource();

    static {
        ds.setDriverClassName("org.postgresql.Driver");
        ds.setUrl(url);
        ds.setUsername(user);
        ds.setPassword(password);
        ds.setMinIdle(5);
        ds.setMaxIdle(10);
        ds.setMaxOpenPreparedStatements(100);
    }

    @Bean
    public static BasicDataSource dataSource() {
        return ds;
    }

    public static void main(String[] args) {
        System.out.println("Starting TestConnect...");
        try (Connection conn = ds.getConnection()) {
            if (conn != null) {
                System.out.println("Successfully connected to the database!");
            } else {
                System.out.println("Failed to make a connection!");
            }
        } catch (SQLException err) {
            System.out.println("SQL Exception: " + err.getMessage());
        }
    }

}

//REF: https://www.baeldung.com/java-connection-pooling