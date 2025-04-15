
![{6D676BD4-A620-4189-B782-F2548EEDB1A4}](https://github.com/user-attachments/assets/50cc83c4-858b-49e4-aea3-c163853d9d2c)

# Description

**AuditArmor** is a highly sophisticated and efficient web security tool designed to scan for potential vulnerabilities in your web applications. It uses a combination of advanced techniques, incorporating popular tools like `waybackurls` and `curl`, to passively and quickly scan your web applications, providing a fast overview of potential vulnerabilities. The results are displayed in an easy-to-read format in the terminal, and only vulnerable results are saved for further investigation. With its lightweight and fast nature, **AuditArmor** is the perfect tool for any RED Teamer.

---

## What Makes **AuditArmor** Unique

**AuditArmor** stands out because it is highly customized for quick, high-priority checks of known CVEs. The tool reads each URL from the `urls.txt` file and checks for various vulnerabilities, including RCE (Remote Code Execution), CSRF (Cross-Site Request Forgery), LFI (Local File Inclusion), open redirect, Log4J vulnerabilities, RFI (Remote File Inclusion), path traversal, and SQL injection. For each vulnerability, the tool sends a specific HTTP request and analyzes the response to detect potential weaknesses.

If a vulnerability is detected, **AuditArmor** writes a message to the `domain.txt` file indicating the URL is vulnerable. If no vulnerability is found, the tool logs that the URL is safe.

---

## The Flow & Methodology

**AuditArmor** begins by asking the user to input the domain they wish to scan. It then creates a folder to store the results and initiates the scanning process. The tool leverages `curl` to make HTTP requests to the target domain, checking for various vulnerabilities by injecting known payloads. It then analyzes the responses to identify signs of exploitation and validates the results to determine whether the target is truly vulnerable.

The methodology behind **AuditArmor** is meticulously designed to ensure that each vulnerability is specifically and thoroughly checked. The tool employs a highly analytical approach that ensures even the most elusive vulnerabilities are identified. Its efficiency and effectiveness make it the ultimate choice for red team security experts and web security professionals.

In conclusion, **AuditArmor** combines advanced technology, a solid methodology, and expert-level logic to create the ultimate tool for identifying and mitigating web application vulnerabilities. Sometimes speed is critical—if you need tools that are focused on in-depth analysis rather than speed, please explore our other offerings.


# Features:

Scans for various web application vulnerabilities, including:

- File Upload

- Command Injection

- Host Header Injection

- HTTP Parameter Pollution (HPP)

- Clickjacking

- CORS Misconfiguration

- Sensitive Data Exposure

- Session Fixation

- XSS (Cross-site scripting)

- SSRF (Server-side request forgery)

- XXE (XML external entity)

- Insecure deserialization

- Remote Code Execution via Shellshock (RCE)

- SQL Injection (SQLi)

- Cross-Site Scripting (XSS)

- Cross-Site Request Forgery (CSRF)

- Remote Code Execution (RCE)

- Log4J

- Directory Traversal (DT)

- File Inclusion (FI)

- Sensitive Data Exposure (SDE)

- Server Side Request Forgery (SSRF)

- Shell Injection (SI)

- Broken Access Control (BAC)

- Generates Random Sun Tzu Quote for Red Teamers, Checks if you are connected to the Internet too!

- Utilizes tools such as waybackurls, curl, and others for comprehensive vulnerability assessments

- Lightweight and fast, delivering results in real-time directly to the terminal

- Only reports vulnerabilities, making it easy to prioritize and remediate vulnerabilities in a timely manner


# Requirements:

- waybackurls: This tool can be installed by running `go install github.com/tomnomnom/waybackurls@latest`

- cURL: This tool is commonly pre-installed on Kali Linux and Ubuntu, but can be installed by running `apt-get install curl` on Ubuntu or `brew install curl` on MacOS

- httpx: is a fast and multi-purpose HTTP toolkit that allows running multiple probes using the retryable http library. To install it: `go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest`

- lolcat: `pip install lolcat` for rainbow beauty
- You also need, toilet, fortune-mod but the new update will install them in the beginning.

# Installation

`git clone https://github.com/hariharan136/AuditArmor.git`

`cd AuditArmor`

`chmod +x AuditArmor.sh`

`./AuditArmor.sh`

# Compatibility: 

This tool has been tested on Kali Linux, Ubuntu and MacOS.

