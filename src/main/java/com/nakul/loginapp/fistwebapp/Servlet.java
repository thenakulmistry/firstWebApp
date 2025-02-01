package com.nakul.loginapp.fistwebapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

@WebServlet(name = "Servlet", value = "/servlet")
public class Servlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("Servlet initialized!");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String apiKey = "d74f4b4d5d106890e7c1f1beb5161141";
        String city = request.getParameter("userInput");

        String apiURL = "https://api.openweathermap.org/data/2.5/weather?q=" +city+ "&appid=" +apiKey;

        try{
            URL url = new URL(apiURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            InputStream inputStream = conn.getInputStream();
            InputStreamReader reader = new InputStreamReader(inputStream);

            Scanner sc = new Scanner(reader);
            StringBuilder responseContent = new StringBuilder();

            while(sc.hasNext()) responseContent.append(sc.nextLine());

            sc.close();

            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(responseContent.toString(), JsonObject.class);

            long dateTimeStamp = jsonObject.get("dt").getAsLong() * 1000;
            String date = new Date(dateTimeStamp).toString();

            double tempK = jsonObject.getAsJsonObject("main").get("temp").getAsDouble();
            int tempC = (int) (tempK - 273.15);

            int humidity = jsonObject.getAsJsonObject("main").get("humidity").getAsInt();

            double wind = jsonObject.getAsJsonObject("wind").get("speed").getAsDouble();

            String weather = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("main").getAsString();

            request.setAttribute("date", date);
            request.setAttribute("city", city);
            request.setAttribute("temp", tempC);
            request.setAttribute("humidity", humidity);
            request.setAttribute("wind", wind);
            request.setAttribute("weather", weather);
            request.setAttribute("weatherData", responseContent.toString());

            conn.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching weather data. Please try again.");
        } catch (JsonSyntaxException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid data received from the weather service.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}