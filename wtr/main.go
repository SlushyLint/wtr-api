package main

import(
    "fmt"
    "io"
    // "os"
    "net/http"
)
var res *http.Response
func wget(url string) {
    var err error
    res, err = http.Get(url)
    if err != nil {
        fmt.Printf("shit happened :/")
        return
    }
}


func read() {
    var err error
    wget("https://api.open-meteo.com/v1/forecast?latitude=39.1582&longitude=-75.5244&current=temperature_2m")
    out, err := io.ReadAll(res.Body)
    
    if err != nil {
        fmt.Printf("Shit happened again :/")
    } else {
        fmt.Print(string(out))
    }

}


func main() {
    read()
}
