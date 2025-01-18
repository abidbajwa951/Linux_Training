# Guide to Sudo Command

The `sudo` command allows a permitted user to execute a command as the superuser or another user, as specified by the security policy. It is a powerful tool for granting controlled administrative access.

Meaning of sudo is “substitute user do” or “super user do”

---

## **Syntax of `sudo`**
```bash
sudo [OPTIONS] COMMAND
```

### **Options:**
- `-u [USER]`: Run the command as the specified user (default is `root`).
- `-l`: List allowed and forbidden commands for the current user.

### **Examples:**
1. **Run a Command as Root:**
   ```bash
   sudo apt update
   ```
2. **Run a Command as Another User:**
   ```bash
   sudo -u username command
   ```
3. **List Allowed Commands:**
   ```bash
   sudo -l
   ```

---

## **Configuring `sudo` Access**

`sudo` access is configured in the `/etc/sudoers` file. Use the `visudo` command to edit this file safely.

### **Basic Syntax in `sudoers`:**
```plaintext
<user/group> <hosts>=<user as> <commands>
```
- **`<user/group>`:** Specify the username or group (prefixed with `%` for groups).
- **`<hosts>`:** Define where the rule applies (use `ALL` for all hosts).
- **`<user as>`:** Specify the user to execute the command as (default is `ALL`).
- **`<commands>`:** Define the allowed commands.

### **Example Configuration:**
```plaintext
john ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt upgrade
%admin ALL=(ALL) ALL
```

---

## **Methods for Configuring `sudo`**

### **1. User-Based Access**
#### **Allow a Specific User to Execute Specific Commands**
**Example:**
Allow `john` to run `apt update` and `apt upgrade` as root without a password:
```plaintext
john ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt upgrade
```

**Verification:**
```bash
su - john
sudo apt update
```

---

### **2. Group-Based Access**
#### **Grant a Group Access to Specific Commands**
**Example:**
Allow the `admin` group to restart the `nginx` service:
```plaintext
%admin ALL=(ALL) NOPASSWD: /bin/systemctl restart nginx
```

**Verification:**
```bash
sudo systemctl restart nginx
```

---

### **3. Restrict Access to Specific Paths**
#### **Allow Commands Only in a Specific Directory**
**Example:**
Allow `pathuser` to execute scripts in `/opt/scripts/`:
```plaintext
pathuser ALL=(ALL) NOPASSWD: /opt/scripts/*
```

**Verification:**
```bash
sudo /opt/scripts/test.sh
```

---

### **4. Command-Specific Access**
#### **Allow Access to Specific Utilities**
**Example:**
Allow `utilityuser` to use `rsync` and `tar` commands only:
```plaintext
utilityuser ALL=(ALL) NOPASSWD: /usr/bin/rsync, /usr/bin/tar
```

**Verification:**
```bash
sudo rsync -av /source /destination
sudo tar -czf backup.tar.gz /folder
```

---

### **5. Deny Specific Commands**
#### **Block a User from Running Certain Commands**
**Example:**
Deny `restricteduser` the ability to use `reboot` and `shutdown`:
```plaintext
restricteduser ALL=(ALL) NOPASSWD: ALL, !/sbin/reboot, !/sbin/shutdown
```

**Verification:**
```bash
sudo reboot  # Should fail
```

---

### **6. Logging and Monitoring**
#### **Enable Detailed Logging for Sudo Commands**
**Configuration:**
Enable logging in the `/etc/sudoers` file:

Logs are typically stored in `/var/log/sudo` or `/var/log/secure` (depending on the system).

**Verification:**
```bash
sudo command
cat /var/log/sudo
```

---
### **7. Sudo Alias**
#### **Configure Sudo with Alias**

```bash
# User alias specification
User_Alias FULLTIMERS = albert, ronald, ann
# Runas alias specification
Runas_Alias	OP = root, operator
Runas_Alias	DB = oracle, mysql
# Host alias specification
Host_Alias	PRODSERVERS = master, mail, www, ns
Host_Alias	DEVSERVERS = testdb, devapp1, preprod
# Cmnd alias specification 
Cmnd_Alias	REBOOT = /usr/sbin/reboot
Cmnd_Alias	VIEWSHADOW = /usr/bin/cat /etc/shadow
# User specification
# root and users in group wheel can run anything on any machine as any user
root		ALL = (ALL) ALL
%wheel		ALL = (ALL) ALL

# full time users can run anything on any machine without a password
FULLTIMERS	ALL = NOPASSWD: ALL
# peter may run anything on machines in DEVSERVERS
peter		DEVSERVERS = ALL
# jane may change passwords for anyone (except root) on PRODSERVERS
jane		PRODSERVERS = /usr/bin/passwd [A-z]*, !/usr/bin/passwd root
# sam may run anything on the DEVSERVERS as DB owns(oracle, mysql).
sam		DEVSERVERS = (DB) ALL
# martin can run commands as oracle or mysql without a password
fred		ALL = (DB) NOPASSWD: ALL
# jen can run VIEWSHADOW commands on all machines except the ones PRODSERVERS
jen		ALL, !PRODSERVERS = VIEWSHADOW
```
## **Testing Configurations**
Use the `sudo -l` command to verify configurations:
```bash
sudo -l
```
This lists the commands the user can execute and any restrictions applied.

---
