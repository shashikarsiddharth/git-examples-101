### Question: Build a Bash Log Parser
You are given a web server access log file. Each line in the log represents one HTTP request.
Write a Bash script that analyzes a web server access log and generates a useful summary report.

### Sample Output Exmaple
```bash
log_parser.sh
```
The script should accept the log file path as an argument:

```bash
./log_parser.sh access.log
```

The script should read the log file and print a summary report containing the following info if no flag/ option is provided:
1. Total number of requests
2. Number of unique IP addresses
3. Top 5 IP addresses by request count
4. Top 5 requested endpoints
5. Count of each HTTP status code
6. Top 5 slowest requests, if request time is present in the log

### Expected Output Format
Your script should print output similar to this when no flag or options in provided:

```text
==== Log Report ====

Total Requests: XX
Unique IPs: XXX

Top 5 IPs:
245 192.168.1.10
180 10.0.0.5
120 192.168.1.22
95 172.16.1.8
80 192.168.1.3

Top 5 Endpoints:
320 /api/users
210 /login
180 /dashboard
90 /api/report
75 /missing

Status Code Count:
200 900 
404 120
301 80 
401 50
500 30

Top 5 Slowest Requests:
0.980 GET /api/report
0.754 POST /login
0.701 GET /dashboard
```
---

### Requirements

The script must:
1. Accept the log file path as a command-line argument.
2. Show a usage message if no file is provided.
3. Check whether the file exists.
4. Check whether the file is readable.
5. Use standard Bash and common Unix tools.
6. Avoid hardcoding the log file name.
7. Produce clean, readable output.

---

### Error Handling
If the user does not pass a file:

```bash
./log_parser.sh
```

Print:

```text
Usage: ./log_parser.sh <log-file>
```

If the file does not exist:

```text
Error: File not found
```

If the file is not readable:

```text
Error: File is not readable
```

---

### Additional Requirements
Implement the following features as well.

1. Add `--status` filter.
Example:
```bash
./log_parser.sh access.log --status 404
```
Output only requests with status code `404`.

2. Add `--method` filter.
Example:
```bash
./log_parser.sh access.log --method POST
```
Output only `POST` requests.

3. Save the report to a file:
Example:
```bash
./log_parser.sh access.log > report.txt
```