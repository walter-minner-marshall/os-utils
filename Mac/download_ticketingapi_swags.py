import requests

# URL of the OpenAPI spec
url_dev = "https://gateway-api.dev.ticketing.golfnowone.dev/swagger/v1-management/swagger.json"
url_stage = "https://gateway-api.staging.ticketing.golfnowone.dev/swagger/v1-management/swagger.json"

# Send an HTTP GET request to download the OpenAPI spec
response_dev = requests.get(url_dev)
response_stage = requests.get(url_stage)

# Check if the request was successful
#dev
if response_dev.status_code == 200:
    # Save the content to a JSON file
    with open('ticketing_gatewayapi.dev.json', 'w', encoding='utf-8') as file:
        file.write(response_dev.text)
    print("OpenAPI specification downloaded successfully and saved as 'ticketing_gatewayapi.dev.json'")
else:
    print(f"Failed to download OpenAPI spec for dev. HTTP Status Code: {response_dev.status_code}")

#stage
if response_stage.status_code == 200:
    # Save the content to a JSON file
    with open('ticketing_gatewayapi.stage.json', 'w', encoding='utf-8') as file:
        file.write(response_stage.text)
    print("OpenAPI specification downloaded successfully and saved as 'ticketing_gatewayapi.stage.json'")
else:
    print(f"Failed to download OpenAPI spec for stage. HTTP Status Code: {response_stage.status_code}")