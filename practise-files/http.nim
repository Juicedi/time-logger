import streams
import json
import httpClient
from base64 import encode

#[
# TODO: Get all user's tasks and save their name, company, ID
]#

var configStream = newFileStream("../config.json", fmRead)
var configJson = parseJson(configStream.readAll())
var token = getStr(configJson["token"])
var userId = getStr(configJson["userId"])
var baseUrl = getStr(configJson["baseUrl"])

var url = baseUrl & "/tasks.json"
var params = "?pageSize=100&include=overdue,nodate&sort=duedate" &
  "&responsible-party-ids=" & $userId

var output = newFileStream("output.txt", fmWrite)
var auth = encode(token & ":xxx", lineLen=1024)

var client = newHttpClient()
var response: string
var parsedJson: JsonNode

client.headers = newHttpHeaders({
  "Content-Type": "Application/json",
  "Authorization": "Basic " & auth
})

response = client.getContent(url & params)
parsedJson = parseJson(response)

for item in parsedJson["todo-items"]:
  output.writeLine(getStr(item["company-name"]) & getStr(item["content"]))
output.close()
