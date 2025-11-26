package org.example.nexus.util;

import java.security.MessageDigest;

public class PasswordUtil {

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());

            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();

            for (byte b : bytes) sb.append(String.format("%02x", b));

            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return password;
        }
    }
}
