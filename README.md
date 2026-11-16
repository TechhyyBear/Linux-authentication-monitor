# Linux Authentication Monitoring & Detection

**Independent Cybersecurity Home Lab**

**Technologies:** Kali Linux | Oracle VirtualBox | Bash | journalctl | PAM | sudo

## Project Overview

Developed a lightweight Bash-based security-monitoring tool to identify failed Linux authentication attempts, classify detected activity, and produce structured investigation reports.

The project was completed in an isolated VirtualBox lab environment as part of independent cybersecurity skills development.

## Security Objective

Demonstrate foundational security operations capabilities by:

- Identifying authentication failures in Linux system logs.
- Correlating authentication activity with timestamps.
- Implementing detection thresholds.
- Generating structured monitoring reports.
- Validating detection behavior through controlled testing.

## Lab Environment

- **Operating System:** Kali Linux
- **Virtualization:** Oracle VirtualBox
- **Network:** Internal Network
- **Log Source:** systemd journal
- **Monitoring Window:** Five minutes
- **Implementation:** Bash script using journalctl and grep

## Detection Logic

| Condition | Classification |
|---|---|
| Zero authentication failures | OK |
| One or two authentication failures | NOTICE |
| Three or more authentication failures | ALERT |

The script examines recent journal entries containing the phrase `authentication failure`.

These thresholds are instructional examples, not production-validated detection rules.

## Testing and Validation

**Test 1 — Normal activity**

Executed the monitoring script when no matching authentication failures were present within the monitoring window.

**Result:** OK.

**Test 2 — Controlled authentication failure**

Intentionally generated one unsuccessful sudo authentication attempt and verified that the monitoring script identified the corresponding event.

**Result:** NOTICE.

**Test 3 — Alert threshold**

Simulated a detection count of three to verify that the alert classification executed correctly in Version 1.

**Result:** ALERT.

**Test 4 — Event evidence**

Verified that the monitoring report displayed an authentication failure message with an event timestamp.

**Result:** Successful.

**Test 5 — Structured reporting**

Developed Version 2 to display scan time, monitoring window, failure count, classification, and event evidence.

**Result:** Successfully tested with a controlled authentication failure.

## Project Files

- `auth-monitor-v2.sh` — Bash monitoring script.
- `evidence/auth-report-sanitized.txt` — User-reviewed, sanitized monitoring report.

## Limitations

- Monitoring runs manually rather than continuously.
- Detection relies on a specific authentication failure phrase.
- The monitoring window is limited to five minutes.
- Detection thresholds have not been validated against real-world attack patterns.
- The Version 2 ALERT condition has not been independently tested.
- The tool does not provide centralized SIEM capabilities.

## Future Improvements

- Automated scheduled monitoring.
- Persistent detection history.
- Improved authentication-event parsing.
- Additional detection rules.
- Integration with a centralized monitoring platform.

## Skills Demonstrated

Linux administration fundamentals, authentication log analysis, Bash scripting, security monitoring, detection logic, controlled testing, and technical documentation.

**Project scope:** Independent training and experimentation. This project does not represent production SOC employment or investigation of a real-world attack.
