package org.example.nexus.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/futuredeveloperslms";
    private static final String USER = "pushkar";
    private static final String PASSWORD = "root123";
    private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

    private static Connection connection = null;

    static {
        try {
            Class.forName(DRIVER_CLASS);
         }
        catch (ClassNotFoundException e)
         {
            System.out.println("❌ MySQL Driver not found!");
            System.out.println(e.getMessage());
         }
    }

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ Database connected successfully.");
            }
        } catch (SQLException e) {
            System.out.println("❌ Database connection failed!");
            System.out.println(e.getMessage());
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("🔒 Database connection closed.");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
