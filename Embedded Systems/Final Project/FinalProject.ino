/*
 * Rui Santos's code used as a template.
 * Complete project details at https://randomnerdtutorials.com  
 */

// Load Wi-Fi library
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <WiFiClient.h>

// Replace with your network credentials
const char* ssid     = "MY_SSID";
const char* password = "MY_PASSWORD";

// Set web server port number to 80
WiFiServer server(80);

// Variable to store the HTTP request
String header;

// Array for receiving the 4-number code.
unsigned int code[4];
unsigned int i, attempt;
String output, pass_code, attempt_str, attempt_status;

// Current time
unsigned long currentTime = millis();
// Previous time
unsigned long previousTime = 0; 
// Define timeout time in milliseconds (example: 2000ms = 2s)
const long timeoutTime = 20000;

// Soft-AP config
IPAddress ip(192,168,1,39);
IPAddress gateway(192,168,1,1);
IPAddress subnet(255,255,255,0);

void setup() {
  Serial.begin(9600); // *** Baud rate setting. ***
  /*Serial.print("Setting up the soft-AP config ... ");
  Serial.println(WiFi.softAPConfig(local_IP, gateway, subnet) ? "Ready" : "Failed");
  Serial.print("Setting up soft-AP ... ");
  Serial.println(WiFi.softAP(ssid) ? "Ready" : "Failed");
  Serial.print("Soft-AP IP Address: ");
  Serial.println(WiFi.softAPIP());
  Serial.setDebugOutput(true);*/
  
  // Initialize the output string, the pass code, i, the attempt #, attempt string, and attempt status.
  output = "";
  pass_code = "4581";
  i = 0;
  attempt = 0;
  attempt_str = "";
  attempt_status = "";

  // Connect to Wi-Fi network with SSID and password
  /*ESP.eraseConfig();
  WiFi.disconnect();
  WiFi.setAutoConnect(false);
  WiFi.setAutoReconnect(false);*/
  //WiFi.hostname("ESP-5A2DA2");
  //WiFi.disconnect();
  //WiFi.config(ip, gateway, gateway, subnet); // Before WiFi connection...?
  WiFi.mode(WIFI_STA);
  //Serial.print("Connecting to ");
  //Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  //Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
}

void loop(){
  unsigned char serial_in;
  
  WiFiClient client = server.available();   // Listen for incoming clients
  
  if (client) {                             // If a new client connects,
    //Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    currentTime = millis();
    previousTime = currentTime;
    while (client.connected() && currentTime - previousTime <= timeoutTime) { // loop while the client's connected
      currentTime = millis();         
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        //Serial.write(c);                    // print it out the serial monitor
        header += c;
        
        if (c == '\n') {                    // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            
            // Display the HTML web page
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            client.println("<style>html { font-family: \"Lucida Sans Unicode\", \"Lucida Grande\", sans-serif; color: white; background-color: black; display: inline-block; margin: 0px auto;}");
            client.println("h1 { text-align: left } </style></head>");
            
            // Web Page Heading
            client.println("<body><h1>Pass Code System</h1>");

            // Web page body.
            client.println("<p style=\"display: inline-block\">Current Pass Code:</p>");
            client.println("<button id=\"ShowHideBut0\" onclick=\"ShowHidePassCode()\">Show</button>");
            client.println("<div id=\"PassCodeDiv\" style=\"display: none\">" + pass_code + "</div>");
            client.println("<br>");
            client.println("<p style=\"display: inline-block\">Attempt #" + attempt_str + ": " + output + " --- Status: " + attempt_status + "</p>");

            // HTML script.
            client.println("<script>");
            client.println("function ShowHidePassCode() {");
            client.println("var div0 = document.getElementById(\"PassCodeDiv\");");
            client.println("var but0 = document.getElementById(\"ShowHideBut0\");");
            client.println("if (div0.style.display === \"none\") {");
            client.println("  div0.style.display = \"inline-block\";");
            client.println("}else {");
            client.println("  div0.style.display = \"none\";");
            client.println("}");
            client.println("if (but0.innerHTML === \"Show\") {");
            client.println("  but0.innerHTML = \"Hide\";");
            client.println("}else {");
            client.println("  but0.innerHTML = \"Show\";");
            client.println("}");
            client.println("}");
            client.println("</script>");

            // Ending body tag.
            client.println("</body></html>");
            
            // The HTTP response ends with another blank line
            client.println();
            
            // Break out of the while loop
            break;
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    //Serial.println("Client disconnected.");
    //Serial.println("");
  }

  unsigned int x;
  while(Serial.available() > 0) {
    serial_in = Serial.read();
    Serial.println(serial_in);
    
    if (serial_in >= '0' && serial_in <= '9') {
      code[i] = (serial_in - 48);

      if (i == 3) {
        output = "";
        ++attempt;

        attempt_str = String(attempt);

        for(x = 0; x < 4; ++x) {
          switch(code[x]) {
            case 0: output = output + "0";
                    break;
            case 1: output = output + "1";
                    break;
            case 2: output = output + "2";
                    break;
            case 3: output = output + "3";
                    break;
            case 4: output = output + "4";
                    break;
            case 5: output = output + "5";
                    break;
            case 6: output = output + "6";
                    break;
            case 7: output = output + "7";
                    break;
            case 8: output = output + "8";
                    break;
            case 9: output = output + "9";
                    break;
          }
        }

        if (output == pass_code) {
          attempt_status = "Accepted";
        }else {
          attempt_status = "Denied";
        }
        
        i = 0;
      }else ++i;
    }
  }
}
