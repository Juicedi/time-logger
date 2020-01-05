import streams
import json
import httpClient
from base64 import encode

var configStream = newFileStream("../config.json", fmRead)
var configJson = parseJson(configStream.readAll())
var baseUrl = getStr(configJson["baseUrl"])
var userId = getStr(configJson["userId"])
var token = getStr(configJson["token"])

var url = baseUrl & "/tasks.json"
var params = "?pageSize=100&include=overdue,nodate&sort=duedate" &
  "&responsible-party-ids=" & $userId

var outputStream = newFileStream("output.txt", fmWrite)
var authorizationToken = encode(token & ":xxx", lineLen=1024)

var client = newHttpClient()
var responseString: string
var responseObject: JsonNode

client.headers = newHttpHeaders({
  "Content-Type": "Application/json",
  "Authorization": "Basic " & authorizationToken
})

responseString = client.getContent(url & params)
responseObject = parseJson(responseString)

for item in responseObject["todo-items"]:
  var line = getStr(item["company-name"]) & ": " & getStr(item["content"])
  outputStream.writeLine(line)

outputStream.close()
