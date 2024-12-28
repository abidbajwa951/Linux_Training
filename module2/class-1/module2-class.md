# Linux Training Module 2:

## 1. `ls` Command:

### Options and Descriptions

| Option | Description |
|--------|-------------|
| `-l`   | Known as a long format that displays detailed information about files and directories. |
| `-a`   | Represent all files. Includes hidden files and directories in the listing. |
| `-t`   | Sort files and directories by their last modification time, displaying the most recently modified ones first. |
| `-r`   | Known as reverse order, used to reverse the default order of listing. |
| `-S`   | Sort files and directories by their sizes, listing the largest ones first. |
| `-R`   | List files and directories recursively, including subdirectories. |
| `-i`   | Known as inode, which displays the index number (inode) of each file and directory. |
| `-g`   | Known as group, which displays the group ownership of files and directories instead of the owner. |
| `-h`   | Print file sizes in human-readable format (e.g., 1K, 234M, 2G). |
| `-d`   | List directories themselves, rather than their contents. |

### Additional Commands

- `ls -F`: Appends a character to each entry to indicate the file type (e.g., `/` for directories, `*` for executables).
- `ls -n`: Displays file information numerically, including user and group IDs instead of names.

### File Types

- `*`: Normal file
- `d`: Directory
- `s`: Socket file
- `l`: Link file

---

## 2. `cd` Command:

### Common Options and Use Cases

| Option/Use Case     | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| `cd [directory]`    | Navigate to the specified directory.                                       |
| `cd ..`             | Move up one level to the parent directory.                                |
| `cd /path/to/dir`   | Navigate to an absolute path.                                              |
| `cd ~` or `cd`      | Move to the home directory.                                                |
| `cd -`              | Return to the previous directory you were in.                             |
| `cd ../..`          | Move up two levels in the directory hierarchy.                            |
| `cd /`              | Navigate to the root directory of the file system.                        |
| `cd ./directory`    | Navigate to a subdirectory relative to the current directory.             |
| `cd ~/directory`    | Navigate to a subdirectory of your home directory.                        |
| `cd /path/to/dir && pwd` | Combine commands to navigate to a directory and confirm with `pwd`. |


- **Example**:
  ```bash
  ln -s /tmp mytmp
  cd -L mytmp
  cd -P mytmp
  pwd
  ```
  - If `mytmp` is a symbolic link to `/tmp`, `cd -L mytmp` will follow the link to `/tmp` and print `/tmp` as the current directory.

---

## 3. `pwd` Command:
The `pwd` (print working directory) command is used to display the full path of the current working directory in the Linux file system. This command is essential for verifying your location within the directory structure.

### Options

| Option | Description                                                                 |
|--------|-----------------------------------------------------------------------------|
| `-L`   | Displays the logical path of the current directory, including symbolic links. |
| `-P`   | Displays the physical path of the current directory, resolving symbolic links. |

---

## 4. `cp` Command: Copy Files and Directories

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-r`   | Copy directories recursively.                |
| `-i`   | Prompt before overwriting files.             |
| `-v`   | Display verbose output during the operation. |

### Examples
1. Copy a file:
   ```bash
   cp file1.txt file2.txt
   ```
2. Copy a directory recursively:
   ```bash
   cp -r dir1 dir2
   ```
3. Copy with a prompt before overwriting:
   ```bash
   cp -i file1.txt file2.txt
   ```

---

## 5. `mv` Command: Move or Rename Files and Directories

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-i`   | Prompt before overwriting files.             |
| `-v`   | Display verbose output during the operation. |

### Examples
1. Move a file to another directory:
   ```bash
   mv file1.txt /path/to/destination/
   ```
2. Rename a file:
   ```bash
   mv oldname.txt newname.txt
   ```
3. Move with a prompt before overwriting:
   ```bash
   mv -i file1.txt file2.txt
   ```

---

## 6. `rm` Command: Remove Files and Directories

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-r`   | Remove directories and their contents recursively. |
| `-i`   | Prompt before each file is removed.          |
| `-f`   | Force removal without prompt.                |

### Examples
1. Remove a file:
   ```bash
   rm file1.txt
   ```
2. Remove a directory and its contents:
   ```bash
   rm -r dir1
   ```
3. Remove a file without prompt:
   ```bash
   rm -f file1.txt
   ```

---

## 7. `mkdir` Command: Create Directories

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-p`   | Create parent directories as needed.         |
| `-v`   | Display verbose output.                      |

### Examples
1. Create a single directory:
   ```bash
   mkdir newdir
   ```
2. Create nested directories:
   ```bash
   mkdir -p parentdir/childdir
   ```
3. Create with verbose output:
   ```bash
   mkdir -v newdir
   ```

---

## 8. `touch` Command: Create Empty Files

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-c`   | Do not create files if they do not exist.    |
| `-t`   | Specify a timestamp for the file.            |

### Examples
1. Create an empty file:
   ```bash
   touch file1.txt
   ```
2. Update the timestamp of an existing file:
   ```bash
   touch file1.txt
   ```
3. Create a file with a specific timestamp:
   ```bash
   touch -t 202412281200 file1.txt
   ```
---

# Viewing Files Commands

This guide covers commands for viewing files in Linux: `cat`, `less`, `head`, and `tail`. These commands are essential for examining file content in different ways.

---

## 9. `cat` Command: Concatenate and Display File Content

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-n`   | Number all output lines.                     |
| `-b`   | Number non-blank output lines.               |

### Examples
1. Display the content of a file:
   ```bash
   cat file.txt
   ```
2. Display with line numbers:
   ```bash
   cat -n file.txt
   ```
3. Combine multiple files and display:
   ```bash
   cat file1.txt file2.txt
   ```

---

## 10. `less` Command: View File Content One Screen at a Time

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-N`   | Show line numbers.                          |
| `/pattern` | Search for a pattern in the file.         |

### Examples
1. View a file:
   ```bash
   less file.txt
   ```
2. Search for a keyword in a file:
   ```bash
   less file.txt
   /keyword
   ```
3. Show line numbers while viewing:
   ```bash
   less -N file.txt
   ```

---

## 11. `head` Command: Display the Beginning of a File

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-n`   | Specify the number of lines to display.      |

### Examples
1. Display the first 10 lines of a file:
   ```bash
   head file.txt
   ```
2. Display the first 5 lines of a file:
   ```bash
   head -n 5 file.txt
   ```

---

## 12. `tail` Command: Display the End of a File

### Common Options
| Option | Description                                  |
|--------|----------------------------------------------|
| `-n`   | Specify the number of lines to display.      |
| `-f`   | Follow the file as it grows.                 |

### Examples
1. Display the last 10 lines of a file:
   ```bash
   tail file.txt
   ```
2. Display the last 5 lines of a file:
   ```bash
   tail -n 5 file.txt
   ```
3. Follow a file in real-time:
   ```bash
   tail -f logfile.txt
   ```
---