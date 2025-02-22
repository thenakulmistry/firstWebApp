<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weather App - Results</title>
    <link rel="stylesheet" href="indexStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Additional Styles for Weather Details */
        .weather-container {
            margin-top: 2rem;
            padding: 2rem;
            border-radius: 15px;
            background-color: #333333;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease-in-out;
        }

        .weather-details {
            margin-top: 1.5rem;
            text-align: left;
        }

        .weather-details p {
            font-size: 1.2rem;
            margin: 1rem 0;
            color: #ffffff;
        }

        .weather-details .icon {
            font-size: 2rem;
            margin-right: 1rem;
            color: #00ff88;
        }

        .weather-details strong {
            color: #00ff88;
        }

        .error {
            color: #ff4444;
            font-size: 1.2rem;
            font-weight: bold;
            margin-top: 1rem;
        }

        /* Clock Styles */
        .clock {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-left: 10px;
        }

        .clock i {
            font-size: 1.2rem;
            animation: spin 2s linear infinite;
        }

        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes spin {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="title">Weather App</h1>
    <div class="search-container">
        <form action="servlet" method="POST">
            <input name="userInput" type="text" id="cityInput" placeholder="Enter city name" class="search-bar">
            <button id="searchButton" class="search-icon"><i class="fas fa-search"></i></button>
        </form>
    </div>

    <!-- Weather Details Section -->
    <div class="weather-container">
        <c:if test="${not empty weatherData}">
            <h2>Weather in ${city}</h2>
            <div class="weather-details">
                <!-- Live Time Display with Clock -->
                <p>
                    <i class="fas fa-calendar-alt icon"></i>
                    <strong>Date & Time:</strong>
                    <span id="liveTime"></span>
                    <span class="clock">
                        <i class="fas fa-clock"></i>
                        <span id="topClock"></span>
                    </span>
                </p>
                <p><i class="fas fa-thermometer-half icon"></i><strong>Temperature:</strong> ${temp}°C</p>
                <p><i class="fas fa-tint icon"></i><strong>Humidity:</strong> ${humidity}%</p>
                <p><i class="fas fa-wind icon"></i><strong>Wind Speed:</strong> ${wind} m/s</p>
                <p><i class="fas fa-cloud icon"></i><strong>Weather:</strong> ${weather}</p>
            </div>
        </c:if>
    </div>
</div>

<!-- JavaScript for Live Time and Clock -->
<script>
    // Function to update the live time and top clock
    function updateTime() {
        const now = new Date();
        const dateTimeString = now.toLocaleString(); // Format: "MM/DD/YYYY, HH:MM:SS AM/PM"

        // Update live time in weather details
        document.getElementById("liveTime").textContent = dateTimeString;

        // Update top clock
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
    }

    // Update the time every second
    setInterval(updateTime, 1000);

    // Initialize the time immediately
    updateTime();
</script>
</body>
</html>