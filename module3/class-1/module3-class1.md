# Users and Groups Management in Linux

Managing users and groups in Linux is an essential aspect of system administration. Below is a detailed guide to user and group management with examples.

---

## **1. Adding/Removing Users and Groups**

### **Adding Users**
The `useradd` command is used to create a new user in Linux.

#### **Syntax**:
```bash
useradd [options] username
```

#### **Example**:
```bash
# Create a new user named 'john'
sudo useradd john

# Add a home directory for 'john'
sudo useradd -m john

# Specify a custom shell for the user
sudo useradd -s /bin/bash john
```

#### **Verifying User Creation**:
```bash
cat /etc/passwd | grep john
```

### **Removing Users**
The `userdel` command removes a user from the system.

#### **Example**:
```bash
# Remove the user 'john'
sudo userdel john

# Remove the user along with their home directory
sudo userdel -r john
```

---

### **Adding Groups**
The `groupadd` command creates a new group.

#### **Syntax**:
```bash
groupadd [options] groupname
```

#### **Example**:
```bash
# Create a new group named 'developers'
sudo groupadd developers
```

### **Removing Groups**
The `groupdel` command deletes a group.

#### **Example**:
```bash
# Remove the group 'developers'
sudo groupdel developers
```

---

## **2. Group Management and Permissions**

### **Adding a User to a Group**
The `usermod` command is used to add a user to a group.

#### **Example**:
```bash
# Add 'john' to the 'developers' group
sudo usermod -aG developers john
```

### **Viewing Group Membership**
The `groups` command displays the groups a user belongs to.

#### **Example**:
```bash
# Check groups for 'john'
groups john
```

### **Changing Group Ownership**
The `chgrp` command changes the group ownership of a file or directory.

#### **Example**:
```bash
# Change group ownership of 'file.txt' to 'developers'
sudo chgrp developers file.txt
```

### **Changing File Permissions for Groups**
Use `chmod` to modify permissions for the group.

#### **Example**:
```bash
# Grant group write permission to 'file.txt'
sudo chmod g+w file.txt

# Check permissions
ls -l file.txt
```
Output:
```plaintext
-rw-rw-r-- 1 john developers 0 Jan 4 12:00 file.txt
```

---

## **3. Switching Users**

### **Using `su` (Switch User)**
The `su` command allows you to switch to another user account.

#### **Example**:
```bash
# Switch to the user 'john'
su john

# Switch to root user
su -
```

### **Using `sudo` (Execute as Superuser)**
The `sudo` command executes commands with root privileges.

#### **Example**:
```bash
# List contents of a restricted directory
sudo ls /root

# Edit a file as root
sudo nano /etc/passwd
```

### **Configuring Sudo Access**
To grant sudo access to a user, add them to the `sudo` group:
```bash
sudo usermod -aG sudo john
```

---

## **4. Password Management & Policy**

### **Setting or Changing User Passwords**
The `passwd` command is used to set or change user passwords.

#### **Example**:
```bash
# Set a password for 'john'
sudo passwd john

# Change the current user's password
passwd
```

### **Password Aging Policies**
Linux allows configuring password policies such as expiry and minimum/maximum age.

#### **Commands**:
- `chage`: Modify password aging policies.

#### **Example**:
```bash
# Check password aging information for 'john'
sudo chage -l john

# Set password expiry to 90 days
sudo chage -M 90 john

# Force user to change password on next login
sudo chage -d 0 john
```

### **Enforcing Strong Passwords**
Install the `libpam-pwquality` package to enforce strong password policies.

#### **Configuration**:
Edit the file `/etc/security/pwquality.conf`.
