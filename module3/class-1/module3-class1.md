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

### **Configuring Sudo Access**
To grant sudo access to a user, add them to the `sudo` group:
```bash
usermod -aG sudo john
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

----
## **5. Passwd & Shadow Files Syntax**

The `/etc/passwd` and `/etc/shadow` files are critical components in Linux systems for user account management. They store essential information about users, such as usernames, UID, GID, and passwords.

---

## `/etc/passwd` File Syntax
The `/etc/passwd` file contains information about user accounts. Each line in the file represents a single user account and has the following format:

```
username:x:UID:GID:comment:home_directory:shell
```

### Fields in `/etc/passwd`
1. **`username`**: The unique name identifying the user (e.g., `john`, `root`).
2. **`x`**: A placeholder indicating that the password is stored in the `/etc/shadow` file.
3. **`UID`**: The User ID, a unique numeric value assigned to the user.
4. **`GID`**: The Group ID, indicating the user's primary group.
5. **`comment`**: A comment field, often used for the user's full name or description.
6. **`home_directory`**: The path to the user's home directory (e.g., `/home/john`).
7. **`shell`**: The user's default shell (e.g., `/bin/bash`, `/usr/sbin/nologin`).

### Example
```
john:x:1001:1001:John Doe:/home/john:/bin/bash
```
- **`username`**: `john`
- **`password`**: Stored in `/etc/shadow`
- **`UID`**: `1001`
- **`GID`**: `1001`
- **`comment`**: `John Doe`
- **`home_directory`**: `/home/john`
- **`shell`**: `/bin/bash`

---

## `/etc/shadow` File Syntax
The `/etc/shadow` file stores encrypted passwords and additional account settings. Each line corresponds to a user and has the following format:

```
username:password:last_change:min_age:max_age:warn:inactive:expire
```

### Fields in `/etc/shadow`
1. **`username`**: The name of the user.
2. **`password`**: The hashed password or a placeholder (e.g., `!`, `!!`, or `*`).
3. **`last_change`**: The number of days since January 1, 1970, when the password was last changed.
4. **`min_age`**: The minimum number of days before the password can be changed.
5. **`max_age`**: The maximum number of days the password is valid.
6. **`warn`**: The number of days before expiration that the user is warned.
7. **`inactive`**: The number of days after password expiration that the account is disabled.
8. **`expire`**: The absolute date (in days since 1970-01-01) when the account expires.

### Example
```
john:$6$abcdefg...:19345:7:90:14:30:20000
```
- **`username`**: `john`
- **`password`**: `$6$abcdefg...` (SHA-512 hashed password)
- **`last_change`**: `19345` (Password last changed on 19345th day since 1970-01-01)
- **`min_age`**: `7` days
- **`max_age`**: `90` days
- **`warn`**: `14` days
- **`inactive`**: `30` days
- **`expire`**: `20000`th day (account expiration date)

---
### Understanding `/etc/shadow` File Syntax

The `/etc/shadow` file stores hashed passwords. The format includes salt, hash, and information about the hashing algorithm used. The structure of a hashed password looks like this:

```bash
$<id>$<salt>$<hash>
```

### Explanation of Fields

#### **`$<id>`: Identifies the hashing algorithm.**
- Example values:
  - `$1$`: MD5
  - `$2a$, $2y$`: bcrypt
  - `$5$`: SHA-256
  - `$6$`: SHA-512

Modern systems generally use `$6$` (SHA-512) for better security.

#### **`$<salt>`: A random value added to the password before hashing.**
The salt ensures that even if two users have the same password, their hashes will differ.

- Example: `saltsalt123`

#### **`$<hash>`: The hashed result of the password combined with the salt.**

```bash
openssl passwd -6 -salt saltsalt123 mypassword
```

`Note:` You cannot decrypt hashed passwords generated using algorithms like SHA-512, bcrypt, or MD5 because they are one-way functions. These algorithms are designed specifically to make decryption infeasible for security reasons.


## Key Differences Between `/etc/passwd` and `/etc/shadow`
| `/etc/passwd`                   | `/etc/shadow`                      |
|---------------------------------|------------------------------------|
| Readable by all users           | Restricted access (root only)      |
| Stores user account information | Stores sensitive password details  |
| Does not contain hashed passwords | Contains hashed passwords        |