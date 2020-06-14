import Foundation
import OWMClient

// swift run owm `cat .apiKey` Boise Chicago

// parse args
let args = Array(CommandLine.arguments.dropFirst())
if args.count < 3 {
    print("requires... apiKey currentCity otherCity")
    exit(EXIT_FAILURE)
}
let apiKey = args[0]
let currentCity = args[1]
let otherCity = args[2]

// init client
let client = OWMClient(apiKey: apiKey)

// run logic
let currentTemp = try client.getTemp(city: currentCity)
let otherTemp = try client.getTemp(city: otherCity)
print(String(format: "diff: %.2f", otherTemp - currentTemp))

// ok
exit(EXIT_SUCCESS)
