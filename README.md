# OWMClient

This is an example client only... not a fully-featured client.

If you don't have an secret API key yet... https://home.openweathermap.org/users/sign_up

Save the API key in the root level of your OWMClient directory like this:

    cd OWMClient
    echo "YOUR_SECRECT_API_KEY" > .apiKey
    
To run the `owm` executable on the command line (which diffs the temp of the two cities you pass in):
    
    swift run owm `cat .apiKey` Boise Chicago
