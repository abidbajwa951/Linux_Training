# SELinux Troubleshooting Guide

SELinux (Security-Enhanced Linux) is a powerful security mechanism, but misconfigurations or violations can cause access issues. This guide provides an overview of common SELinux troubleshooting commands, including `sealert`, `ausearch`, and resolving AVC (Access Vector Cache) denials.

---

## 1. Using `sealert` to Analyze SELinux Logs
`sealert` is part of the `setroubleshoot` package and helps analyze SELinux denials.

### a. Analyze a Specific UUID
SELinux denials often generate a unique UUID. Use the `sealert` command with the `-l` option to get detailed information about a specific denial:
```bash
sealert -l <UUID>
```
#### Example:
```bash
sealert -l 12345678-1234-5678-1234-567812345678
```
This displays a detailed explanation of the denial, possible causes, and suggested fixes.

### b. Analyze the Audit Log
If you don’t have a specific UUID, analyze the audit log to find all SELinux denials:
```bash
sealert -a /var/log/audit/audit.log
```
This scans the entire log file for SELinux denials and provides detailed reports on each.

---

## 2. Using `ausearch` for SELinux Denials
`ausearch` is a utility to query audit logs and extract SELinux-related events.

### a. Search for AVC Denials
To filter and view all AVC (Access Vector Cache) denials:
```bash
ausearch -m avc
```
#### Example Output:
```
type=AVC msg=audit(1674245678.123:456): avc:  denied  { write } for  pid=1234 comm="httpd" path="/var/www/html" dev="sda1" ino=56789 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:default_t:s0 tclass=file
```
### b. Filter AVC Denials by Time
To limit results to recent events, specify a time range:
```bash
ausearch -m avc -ts today
```
You can also use relative times, like `-ts 5m` (last 5 minutes).

---

## 3. Resolving AVC Denials

### a. Understanding the Denial
From the `ausearch` or `sealert` output, identify the following:
- **Source Context (`scontext`)**: The domain of the process causing the denial.
- **Target Context (`tcontext`)**: The domain or type of the object being accessed.
- **Access (`tclass`)**: The type of action being attempted (e.g., `file`, `dir`).
- **Operation (`denied {}`)**: The specific operation being denied (e.g., `read`, `write`).

### b. Suggested Fixes
1. **Temporary Fix**:
   Use `audit2allow` to create a temporary policy allowing the denied action:
   ```bash
   ausearch -m avc -ts today | audit2allow -M mycustompolicy
   sudo semodule -i mycustompolicy.pp
   ```

2. **Persistent Fix (if applicable)**:
   Adjust the SELinux context or Boolean:
   - Set the correct SELinux type:
     ```bash
     sudo semanage fcontext -a -t <type> <path>
     sudo restorecon -Rv <path>
     ```
   - Enable an SELinux Boolean:
     ```bash
     sudo setsebool -P <boolean> on
     ```

---

## 4. Examples of Common Fixes

### Example 1: Web Server Denial
#### Denial:
```
avc:  denied  { read } for  pid=1234 comm="httpd" path="/var/www/html/index.html" scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:default_t:s0 tclass=file
```
#### Fix:
1. Assign the correct SELinux type to the file:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html(/.*)?"
   sudo restorecon -Rv /var/www/html
   ```
2. Verify access:
   ```bash
   ls -Z /var/www/html/index.html
   ```

### Example 2: Allowing Home Directory Access
#### Denial:
```
avc:  denied  { getattr } for  pid=5678 comm="httpd" path="/home/user/public_html" scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir
```
#### Fix:
1. Enable the `httpd_enable_homedirs` Boolean:
   ```bash
   sudo setsebool -P httpd_enable_homedirs on
   ```
2. Update the SELinux type for the home directory:
   ```bash
   sudo semanage fcontext -a -t httpd_sys_content_t "/home/user/public_html(/.*)?"
   sudo restorecon -Rv /home/user/public_html
   ```

---

## Summary
- Use `sealert` and `ausearch` to analyze and understand SELinux denials.
- Correct issues by adjusting SELinux contexts, enabling appropriate Booleans, or creating custom policies.
- Always verify changes to ensure proper system functionality and security.

