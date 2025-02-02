# Administratively Log Out Users

## Overview
System administrators may need to log out users for various reasons, including:
- **Security violations** (e.g., unauthorized access attempts).
- **Excessive resource usage** (e.g., high CPU or memory consumption).
- **Unresponsive sessions** (e.g., frozen or idle processes).
- **Improper access to restricted materials.**

In such cases, the administrator must identify and terminate the user's session using appropriate commands.

## Identifying Active Users
To log off a user, first determine their session details using the `w` or `who` command.

### Using the `w` Command
The `w` command displays logged-in users and their activity:
```sh
w
```
#### Example Output:
```
 11:43:20 up 7:05, 1 user, load average: 0.19, 0.10, 0.03
USER     TTY      LOGIN@   IDLE   JCPU   PCPU WHAT
john     pts/0    06:38    10:15   0.20s  0.05s bash
```
- `TTY` indicates the terminal session (`pts/0` for remote or graphical login, `tty1` for local console).
- `LOGIN@` shows the time the user logged in.
- `IDLE` shows how long the session has been inactive.
- `WHAT` displays the current process the user is running.

### Using the `who` Command
The `who` command provides a simpler view of logged-in users:
```sh
who
```
#### Example Output:
```
john     pts/0    2024-01-31 06:38 (:0)
```
- `pts/0` → User is connected via a pseudo-terminal (remote login or terminal emulator).
- `tty1` → User is on a local console.
- `(:0)` → Indicates a graphical session.

## Logging Out a User
Once the session is identified, administrators can terminate it using `pkill`, `kill`, or `logout`.

### **1. Logging Out a User by Terminal Name**
```sh
pkill -kill -t pts/0
```
This forcefully terminates all processes associated with terminal `pts/0`.

### **2. Killing a Specific User’s Session**
```sh
pkill -u john
```
This terminates all processes owned by the user `john`.

### **3. Logging Out a User Using `kill` and `PID`**
Find the user’s session process ID using `who` or `ps`:
```sh
ps -u john
```
Then, terminate the session:
```sh
kill -9 <PID>
```

### **4. Logging Out All Users Except Root**
```sh
pkill -KILL -u $(who | awk '{print $1}' | grep -v root)
```
This forcefully logs out all non-root users.

# **Monitor Process Activity**

### Objectives
- Understand load average and identify resource-intensive processes.

### Load Average Overview
Load average is a metric provided by the Linux kernel that represents system load over a period of time. It helps determine if system load is increasing or decreasing by tracking pending resource requests.

The kernel collects load data every five seconds and reports an exponential moving average for the past 1, 5, and 15 minutes.

### Load Average Calculation
Load average includes:
- The number of processes ready to run (CPU-bound).
- The number of processes waiting for I/O operations (disk or network-bound).

Unlike some UNIX systems that consider only CPU utilization, Linux includes disk and network usage, as they can impact performance significantly. High load averages with minimal CPU activity indicate disk or network bottlenecks.

### Interpreting Load Average Values
To view load average, use the `uptime` command. It displays three values representing system load over the last 1, 5, and 15 minutes.

#### CPU Utilization and Load Average
- Use `lscpu` to determine the number of CPUs.
- Divide the load average by the number of logical CPUs to assess performance.
- A value below 1 indicates low load and minimal waiting time.
- A value above 1 suggests resource saturation and delays.

Example:
```
load average: 2.92, 4.48, 5.20
System has 4 logical CPUs
Per-CPU load: 0.73, 1.12, 1.30
```
This indicates decreasing load and ~73% CPU usage over the past minute.

### Real-Time Process Monitoring
The `top` command provides dynamic system process monitoring with refresh intervals and sorting options. Unlike `ps`, `top` updates continuously.

#### Default `top` Columns
```
PID   USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND  
```
- **PID**: Process ID – Unique identifier for the process.
- **USER**: The owner of the process.
- **PR**: Process priority – Lower values indicate higher priority.
- **NI**: Nice value – Determines the priority of a process. Lower values mean higher priority.
- **VIRT**: Virtual memory used by the process (includes code, data, and swapped memory).
- **RES**: Resident memory – Actual physical RAM used by the process (excluding swap).
- **SHR**: Shared memory – Amount of shared memory the process is using.
- **S**: Process state: `R` (Running), `S` (Sleeping), `D` (Uninterruptible Sleep), `T` (Stopped/Traced), `Z` (Zombie).
- **%CPU**: Percentage of CPU used by the process.
- **%MEM**: Percentage of physical memory (RAM) used by the process.
- **TIME+**: Total CPU time the process has consumed since it started.
- **COMMAND**: The name of the command that started the process.

#### CPU Usage Summary
```
%Cpu(s):  1.3 us,  1.7 sy,  0.0 ni, 95.5 id,  0.0 wa,  1.2 hi,  0.3 si,  0.0 st  
```
- **us (User Space)**: **1.3%** - CPU time spent executing user processes (non-kernel tasks).
- **sy (System)**: **1.7%** - CPU time spent on system (kernel) processes.
- **ni (Nice)**: **0.0%** - CPU time spent on processes with adjusted nice values.
- **id (Idle)**: **95.5%** - CPU idle time (not being used).
- **wa (Wait I/O)**: **0.0%** - Time waiting for I/O operations (disk, network).
- **hi (Hardware Interrupts)**: **1.2%** - CPU time handling hardware interrupts.
- **si (Software Interrupts)**: **0.3%** - CPU time handling software interrupts.
- **st (Steal Time)**: **0.0%** - Time stolen by hypervisor (for virtual machines).

### Essential `top` Keystrokes
- `? or h`: Help menu
- `1`: Toggle between individual and summary CPU view
- `S`: Adjust screen refresh rate
- `b`: Toggle reverse highlighting for running processes
- `Shift+m`: Sort by memory usage
- `Shift+p`: Sort by CPU usage
- `k`: Kill a process (enter PID)
- `Shift+w`: Save current display settings
- `q`: Quit
- `f`: Manage and customize displayed columns

By understanding load averages and using real-time monitoring tools like `top`, users can efficiently manage system resources and identify performance bottlenecks.

# System Performance Tuning with tuned Daemon

## Overview
The `tuned` daemon is a system tuning tool that optimizes performance by applying predefined tuning profiles. These profiles adjust device settings based on workloads to enhance efficiency.

## Tuning Methods

### 1. Static Tuning
- Applied at startup or when a new profile is selected.
- Configures kernel parameters without real-time adjustments.
- Ensures a consistent performance baseline.

### 2. Dynamic Tuning
- Adjusts settings in real-time based on system activity.
- Optimizes performance dynamically during high workloads.
- Can be enabled in `/etc/tuned/tuned-main.conf` by setting `dynamic_tuning=1`.

## Monitoring & Adjusting System Performance
- The `tuned` daemon uses **monitor plug-ins** to track system activity:
  - `disk`: Monitors disk I/O operations.
  - `net`: Monitors network traffic.
  - `load`: Monitors CPU load.
- **Tuning plug-ins** adjust performance parameters:
  - `disk`: Modifies disk scheduler and power settings.
  - `net`: Configures network speed and Wake-on-LAN.
  - `cpu`: Adjusts CPU governor and latency settings.

## Installing and Enabling tuned
```bash
[root@host ~]$ dnf install tuned
[root@host ~]$ systemctl enable --now tuned
```

## Predefined Tuning Profiles
Tuning profiles optimize system performance based on specific requirements. Examples include:
- `balanced`: Default profile for a balance between power saving and performance.
- `powersave`: Reduces power consumption.
- `throughput-performance`: Maximizes data throughput.
- `virtual-guest`: Optimizes performance for virtual machines.

Profiles are stored in `/usr/lib/tuned/` and `/etc/tuned/`.

## Managing tuned Profiles
### List Available Profiles
```bash
[root@host ~]$ tuned-adm list
```

### Check Active Profile
```bash
[root@host ~]$ tuned-adm active
```

### Switch to a New Profile
```bash
[root@host ~]$ tuned-adm profile throughput-performance
```

### Get Profile Information
```bash
[root@host ~]$ tuned-adm profile_info balanced
```

### Recommend Best Profile
```bash
[root@host ~]$ tuned-adm recommend
```

### Disable tuned
```bash
[root@host ~]$ tuned-adm off
```

## Customizing Profiles
To create a custom profile:
1. Copy an existing profile from `/usr/lib/tuned/` to `/etc/tuned/`.
2. Modify the `tuned.conf` file.
3. Apply the new profile using `tuned-adm profile <profile_name>`.

By using `tuned`, system administrators can enhance system performance efficiently based on workload demands.

# **Influence Process Scheduling**

## **Objectives**
- Learn how to prioritize or deprioritize specific processes using the `nice` and `renice` commands.

---

## **Linux Process Scheduling**
Modern computer systems have multi-core, multi-thread CPUs that can execute multiple instruction threads at once. While a personal workstation is optimized for an individual user’s workload, enterprise servers handle thousands of processes, often leading to CPU saturation.

To manage this, Linux employs **time-slicing (multitasking)**, where the process scheduler rapidly switches between tasks, giving the illusion that multiple processes run simultaneously.

---

## **Process Priorities**
Each process has a **priority level**, which determines how much CPU time it receives. Linux uses scheduling policies to manage processes:
- **Interactive processes** (e.g., user applications)
- **Batch processing** (e.g., background tasks)
- **Real-time processes** (e.g., critical system tasks)

For normal processes, Linux uses the **Completely Fair Scheduler (CFS)**, which organizes processes in a **binary tree** to determine execution order.

---

## **What is a Binary Tree in Scheduling?**
A **binary tree** is a structure used by the CFS scheduler to organize processes based on CPU usage:
- **Processes that have used less CPU time are placed higher** and executed first.
- **Processes with more CPU time are placed lower** and must wait longer.

### **Example of a Binary Tree:**
```
       (Process A) - Least CPU Used  
      /            \  
(Process B)    (Process C)  
    /      \           \  
(D)       (E)         (F) - Most CPU Used  
```
- **Process A runs first**, followed by B and C, ensuring fair CPU distribution.

---

## **Nice Values and Process Priority**
Linux allows users to adjust process priority using the **nice value**:
- **Lower nice value (-20)** → Higher priority (runs sooner)
- **Higher nice value (19)** → Lower priority (runs later)
- **Default nice value is 0**

Example:
- A **video player** might have a **nice value of -5** (higher priority).
- A **background task** like file indexing might have a **nice value of 10** (lower priority).

---

## **Modifying Nice Values**
### **Start a Process with a Nice Value**
By default, new processes inherit their parent’s nice value. The `nice` command can set a custom nice value:

```bash
nice -n 15 sleep 60 &
```
- This starts the `sleep` command with a nice value of `15` (lower priority).

### **Modify an Existing Process's Nice Value**
To change the nice value of a running process, use `renice`:

```bash
renice -n 19 2740
```
- This changes process **2740’s** priority to `19` (lowest priority).

Only **root users** can decrease a process’s nice value (increase priority), while normal users can only increase it.

---

## **Viewing Process Priorities with `ps`**
The `ps` command shows process priorities:

```bash
ps axo pid,comm,nice,cls --sort=-nice
```

### **Example Output:**
```
PID   COMMAND         NI   CLS  
33    khugepaged     10   TS  
32    ksma            5   TS  
814   rtkit-daemon    1   TS  
1     systemd         0   TS  
2     kthreadd        -    TS  
15    migration/0     -    FF  
```
- **CLS (Scheduling Class):**
  - **TS (Time Sharing)** – Default scheduling for normal processes.
  - **FF (First In First Out)** – Real-time scheduling.
  - **R (Round Robin)** – Another real-time scheduling policy.
- Real-time processes (FF/R) **do not** have nice values.

---