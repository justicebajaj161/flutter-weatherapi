const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = 5000;

app.use(express.json());
app.use(cors());
app.get('/weather', async (req, res) => {
  try {
    const { city } = req.query;
    
    console.log(city)
    const apiKey = process.env.WEATHER_API_KEY; 

    
    const response = await axios.get(
      `https://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${city}`
    );

    const weatherData = response.data; 
  console.log(weatherData)
    res.json(weatherData); 
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch weather data' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
