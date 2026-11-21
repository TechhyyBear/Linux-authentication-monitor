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

**Test 1 — Normal activity (Version 2)**

Executed the updated monitoring script when no matching authentication failures were present within the five-minute monitoring window.

**Result:** PASS — Zero failures detected; status classified as OK.

**Test 2 — Controlled authentication failure (Version 2)**

Generated one unsuccessful sudo authentication attempt in the isolated Kali Linux environment. Executed the monitoring script and examined the resulting report.

**Result:** PASS — One authentication failure detected; status classified as NOTICE. The report displayed the corresponding authentication failure event.

**Test 3 — ALERT classification logic (Version 2)**

Executed the Version 2 classification logic separately with a simulated failure count of three.

**Result:** PASS — The logic correctly returned ALERT.

**Validation at the time:** This test exercised only the classification logic. An end-to-end ALERT test was subsequently completed on November 20, 2026 (Test 7).

**Test 4 — Case-insensitive event counting**

Tested the corrected counting command against three sample authentication failure messages using lowercase, mixed-case, and uppercase text.

**Result:** PASS — All three messages were counted successfully.

**Test 5 — Bash syntax validation**

Executed `bash -n` against the updated Version 2 script.

**Result:** PASS — No syntax errors reported.

**Test 6 — Structured reporting (Version 2)**

Executed the complete monitoring script and verified the reported failure count, classification, and authentication event evidence during controlled testing.

**Result:** PASS — The script generated the expected monitoring report.

**Test 7 — End-to-end ALERT scenario (Version 2, November 20, 2026)**

Generated three synthetic `authentication failure` messages using `logger` in the isolated Kali lab and ran the complete script against the five-minute journal window.

**Result:** PASS — Script reported `Failures Detected: 4`, classified the result as `ALERT`, and displayed the three synthetic entries. A separate `lightdm` authentication-failure event also occurred within the window, accounting for the fourth match. This validates the full ALERT path for this lab scenario, not production detection accuracy. See [`evidence/auth-report-alert-sanitized.txt`](evidence/auth-report-alert-sanitized.txt), a manually sanitized transcription of the operator-provided screenshot.

**Testing scope:** All testing was performed in an isolated training environment. Detection thresholds are instructional and have not been validated against production security events.

## Project Files

- `auth-monitor-v2.sh` — Bash monitoring script.
- `evidence/auth-report-sanitized.txt` — User-reviewed, sanitized NOTICE monitoring report.
- `evidence/auth-report-alert-sanitized.txt` — Sanitized transcription and test record for the end-to-end ALERT scenario (November 20, 2026).

## Limitations

- Monitoring runs manually rather than continuously.
- Detection relies on a specific authentication failure phrase.
- The monitoring window is limited to five minutes.
- Detection thresholds have not been validated against real-world attack patterns.
- The end-to-end ALERT lab test observed four matches (three synthetic events plus one separate `lightdm` event); this is a single lab validation, not a repeatability or production-accuracy assessment.
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
