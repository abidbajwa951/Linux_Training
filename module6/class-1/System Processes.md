# Linux `ps` Command - Process Management

## Overview
The `ps` (process status) command is used to display information about active processes in a Linux system. It provides details such as process ID (PID), CPU usage, memory consumption, and process state.

## Syntax
The basic syntax of the `ps` command is:
```sh
ps [options]
```

## Commonly Used `ps` Options
| Option | Description |
|--------|-------------|
| `-e`   | Show all processes. |
| `-f`   | Full-format listing (detailed view). |
| `-u user` | Show processes owned by a specific user. |
| `-aux` | Display all user processes with detailed information. |
| `-ef`  | Show every process in full format. |
| `--forest` | Show process hierarchy in tree format. |

## Understanding `ps aux` Output
Running `ps aux` produces output similar to:
```sh
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      1234  0.5  1.2  24560  5500 pts/0    Ss   12:30   0:01 bash
user      5678  1.2  2.5  85000  10200 pts/1   R+   12:35   0:05 firefox
```

### Explanation of Columns:
| Column  | Description |
|---------|------------|
| **USER**  | Username of the process owner. |
| **PID**   | Process ID (unique identifier). |
| **%CPU**  | Percentage of CPU usage. |
| **%MEM**  | Percentage of system memory used. |
| **VSZ**   | Virtual memory size (in KB). |
| **RSS**   | Resident Set Size (physical memory used, in KB). |
| **TTY**   | Terminal associated with the process (if any). |
| **STAT**  | Process state (explained below). |
| **START** | Time or date the process started. |
| **TIME**  | Total CPU time used. |
| **COMMAND** | The command that started the process. |

## Understanding Process States (`STAT` Column)
The **STAT** column represents the current state of a process:

| Code | Meaning |
|------|---------|
| **R**  | Running: Actively executing or ready to run. |
| **S**  | Sleeping: Waiting for an event (e.g., I/O request). |
| **D**  | Uninterruptible sleep: Usually waiting for disk I/O. |
| **Z**  | Zombie: The process has exited but is still in the process table. |
| **T**  | Stopped: The process is suspended (e.g., `Ctrl+Z`). |
| **X**  | Dead: Terminated but still listed. |
| **<**  | High-priority process. |
| **N**  | Low-priority process. |
| **s**  | Session leader (e.g., shell process). |
| **l**  | Multi-threaded process. |
| **+**  | Foreground process. |

## Practical Examples

### 1. **List All Running Processes**
```sh
ps -e
```

### 2. **Display Full Details of Processes**
```sh
ps -ef
```

### 3. **List Processes of a Specific User**
```sh
ps -u username
```

### 4. **Find a Specific Process by Name**
```sh
ps aux | grep firefox
```

### 5. **Show Process Hierarchy**
```sh
ps -ef --forest
```

### 6. **Monitor a Specific Process**
```sh
watch -n 1 'ps -p <PID> -o pid,stat,%cpu,%mem,cmd'
```
---

# 🖥️ Process vs. 🧵 Thread: Key Differences

| Feature       | Process 🖥️  | Thread 🧵 |
|--------------|------------|----------|
| **Definition** | A program in execution, with its own memory space. | A lightweight unit within a process that shares memory. |
| **Memory** | Each process has separate memory (independent). | Threads share the same memory space. |
| **Communication** | Inter-process communication (IPC) required (slower). | Can communicate easily since they share memory. |
| **Creation Speed** | Slow (requires new memory allocation). | Fast (just a new execution path in an existing process). |
| **Dependency** | Independent of other processes. | Dependent on the parent process. |
| **Crash Effect** | One process crash doesn’t affect others. | A thread crash can crash the entire process. |
| **Example** | Running `firefox` and `chrome` are two separate processes. | Multiple tabs in `firefox` are threads. |

---

## 🔍 How to Identify Processes & Threads in Linux

### 🏃 Check Running Processes:
```bash
ps -e
```

### 🧵 Check Threads in a Process:
```bash
ps -eLf
```
or use `pstree -T` to show threads in a tree format.

## 📌 Simple Analogy:
- A **process** is like a **restaurant**, with its own kitchen (memory).
- **Threads** are like **chefs** working inside the restaurant, sharing the same kitchen (memory).

---

# Linux Process Management

## Kill Processes
### Objectives
- Use commands to kill and communicate with processes.
- Define the characteristics of a daemon process.
- Stop user sessions and processes.

## Process Control with Signals
A **signal** is a software interrupt that is delivered to a process. Signals report events to an executing program. Events that generate a signal can be:
- An error (e.g., segmentation fault)
- An external event (e.g., an I/O request or an expired timer)
- A manually sent signal using commands or keyboard shortcuts

### Default Actions for Signals
Each signal has a default action, which is usually one of the following:
- **Terminate (exit):** Immediately stops the program.
- **Core dump and terminate:** Saves the program's memory image (core dump) before termination.
- **Suspend (stop):** Pauses the program, allowing it to be resumed later.

Programs can react to signals by implementing handler routines to ignore, replace, or extend a signal's default action.

### Common Process Management Signals

| Signal Number | Name  | Description |
|--------------|------|-------------|
| 1  | HUP  | Reports termination of the controlling process of a terminal. Also requests process re-initialization (configuration reload) without termination. |
| 2  | INT  | Causes program termination. It can be blocked or handled. Sent by pressing `Ctrl + C`. |
| 3  | QUIT | Similar to SIGINT; adds a process dump at termination. Sent by pressing `Ctrl + \`. |
| 9  | KILL | Causes abrupt program termination. Cannot be blocked, ignored, or handled. |
| 15 | TERM | The default signal for process termination. Unlike SIGKILL, it allows the program to clean up before terminating. |
| 18 | CONT | Resumes a stopped process. Cannot be blocked. |
| 19 | STOP | Suspends the process. Cannot be blocked or handled. |
| 20 | TSTP | Suspends the process but can be blocked or handled. Sent by pressing `Ctrl + Z`. |

## Sending Signals to Processes
Signals can be sent using commands like `kill`, `pkill`, and `killall`.

### Send Signals by Explicit Request
You can signal the current foreground process using keyboard control sequences:
- `Ctrl + Z`: Suspend the process (`TSTP` signal)
- `Ctrl + C`: Terminate the process (`INT` signal)
- `Ctrl + \`: Core dump and terminate (`QUIT` signal)

For background processes in a different session, use signal-sending commands.

You can specify signals either by:
- **Name** (e.g., `SIGTERM`, `SIGHUP`)
- **Number** (e.g., `15`, `1`)

Users can terminate their processes, but root privileges are required to kill processes owned by other users.

#### Example Usage
```sh
sleep 300 &
```
#### 1. Terminating a Process with `kill`
```sh
kill -TERM <PID>
```
- Sends the `TERM` (15) signal to a process with the given PID.
- Allows the process to clean up before terminating.

#### 2. Forcibly Killing a Process with `kill -9`
```sh
kill -9 <PID>
```
- Sends the `KILL` (9) signal to forcibly terminate the process.
- The process cannot handle or ignore this signal.

#### 3. Stopping and Resuming a Process
```sh
kill -SIGSTOP <PID>  # Suspend process
kill -SIGCONT <PID>  # Resume process
```

#### 4. Killing a Process by Name using `pkill`
```sh
pkill -TERM firefox
```
- Sends `TERM` (15) to all processes named "firefox".

#### 5. Killing All Instances of a Process using `killall`
```sh
killall -9 chrome
```
- Sends `KILL` (9) to all running "chrome" processes.

#### 6. Listing Available Signals
```sh
kill -l
```
- Displays a list of all available signal names and numbers.

#### 7. List Process tree
```sh
pstree -p abid
```

- List processes tree structure
