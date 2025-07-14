# The Weather API: https://www.weatherapi.com/api-explorer.aspx
import requests

# Define the API key and the base URL of the WeatherAPI
api_key = '8232784e010c41a7aa003833250806'  # <-- a tua API Key aqui
base_url = 'http://api.weatherapi.com/v1/current.json'

# Define the city for which you want to retrieve weather data
city = 'Aveiro, Portugal'

# Construct the full URL with the API key and city
url = f"{base_url}?key={api_key}&q={city}&aqi=no"

# Make a GET request to the API endpoint
response = requests.get(url)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Convert the response to JSON format
    weather_data = response.json()

    # Extract relevant weather information
    lat = weather_data['location']['lat']
    lon = weather_data['location']['lon']
    desc = weather_data['current']['condition']['text']
    temp = weather_data['current']['temp_c']
    humidity = weather_data['current']['humidity']
    wind_speed = weather_data['current']['wind_kph']

    # Print results in the required format
    print(f"Weather in Aveiro, Portugal (lat:{lat}, lon:{lon}):")
    print(f"Description: {desc}")
    print(f"Temperature: {temp} Celsius")
    print(f"Humidity: {humidity}%")
    print(f"Wind Speed: {wind_speed} km/h")

else:
    # Print an error message if the request was unsuccessful
    print(f"Error: {response.status_code}")