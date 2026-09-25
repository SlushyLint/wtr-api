package main

import(
    "fmt"
    "io"
    // "os"
    "encoding/json"
    "net/http"
    "bytes"
)
var res *http.Response
func wget(url string) {
    var err error
    res, err = http.Get(url)
    if err != nil {
        return
    }
}
var cur Cur
var weather Weather

type Cur struct {
    Temp float64 `json:"temperature_2m"`
    Time string `json:"time"`
    Humid int `json:"relative_humidity_2m"`
    Interv int `json:"interval"`
    Wind float64 `json:"wind_speed_10m"`
    Code int `json:"weather_code"`

}

type Units struct {
    Temp string `json:"temperature_2m"`
    Humid string `json:"relative_himidity_2m"`
    Wind string `json:"wind_speed_10m"`
    Code string `json:"weather_code:"`
}

type Weather struct {
    Cur Cur `json:"current"`
    Units Units `json:"current_units"`
}

func wtrdisc(code int) string {
    switch code {
    case 0:
        return "Clear sky"
    case 1:
        return "Mainly clear"
    case 2:
        return "Partly cloudy"
    case 3:
        return "Overcast"
    case 45, 48:
        return "Fog"
    case 51, 53, 55, 56, 57:
        return "Drizzle"
    case 61, 63, 65, 66, 67:
        return "Rain"
    case 71, 73, 75, 77:
        return "Snow"
    case 80, 81, 82:
        return "Rain showers"
    case 85, 86:
        return "Snow showers"
    case 95, 96, 99:
        return "Thunderstorm"
    default:
        return "Unknown"
    }
}

func read() {
    wget("https://api.open-meteo.com/v1/forecast?latitude=39.1582&longitude=-75.5244&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code")
    var err error
    out, err := io.ReadAll(res.Body)
    
    if res == nil {
        fmt.Printf("request failed:\n%v\n",err)
        return
    }
    if err != nil {
        fmt.Printf("Shit happened again :/ (%v)\n", err)
        return
    } else {
        var pretty bytes.Buffer
        
        err := json.Indent(&pretty, out, "", "    ")
        if err != nil {
            fmt.Println(err)
            return
        }
        
        fmt.Println(pretty.String())
    }

    fmt.Printf("\n\n\n")
    json.Unmarshal(out, &cur)
    json.Unmarshal(out, &weather)
}


func main() {
    read()
    fmt.Printf("Humidity: ")
    fmt.Println(weather.Cur.Humid, weather.Units.Humid,"%")
    fmt.Printf("Temp: ")
    fmt.Println(weather.Cur.Temp, weather.Units.Temp)
    fmt.Printf("Time: ")
    fmt.Println(weather.Cur.Time)
    fmt.Printf("Interval: ")
    fmt.Println(weather.Cur.Interv)
    fmt.Printf("Wind SPD: ")
    fmt.Println(weather.Cur.Wind, weather.Units.Wind)
    fmt.Println(wtrdisc(weather.Cur.Code))
}
