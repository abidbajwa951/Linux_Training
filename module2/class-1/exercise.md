# Module 2:

# Linux Command Exercises

## Navigation Commands (ls, cd, pwd)

1. **List all files in the current directory including file details (permissions, size, etc.).**  
   Command: `ls -l`

2. **Change the current directory to `/usr/local/bin` and then navigate back to the home directory.**  
   Command: `cd`

3. **Print the full absolute path of the current directory, including any symbolic links.**  
   Command: `pwd -P`

4. **List all files, including hidden files, in the `/etc` directory recursively.**  
   Command: `ls -aR`

5. **Navigate to the root directory (`/`) and list the files and directories there.**  
   Command: `cd / && ls`

---

## File Management Commands (cp, mv, rm, mkdir, touch)

1. **Copy the file `document.txt` to the `/tmp/backup/` directory. Ensure it preserves file attributes.**  
   Command: `cp -p`

2. **Move the file `file1.txt` from the current directory to `/home/username/Documents/` and rename it to `file2.txt`.**  
   Command: `mv`

3. **Remove the file `tempfile.txt` from the `/home/username/tmp/` directory without prompting for confirmation.**  
   Command: `rm -f`

4. **Create a directory named `new_folder` under the `/var/` directory, then create a file `info.txt` inside it.**  
   Command: `mkdir` and `touch`

5. **Create a new empty file called `logfile.log` in the current directory.**  
   Command: `touch`

---

## Viewing Files Commands (cat, less, head, tail)

1. **Display the contents of the file `notes.txt` and redirect any error messages to `error.log`.**  
   Command: `cat`

2. **View the contents of `readme.txt` in a paginated manner. Navigate through it using the spacebar.**  
   Command: `less`

3. **Display the first 20 lines of the file `largefile.txt`.**  
   Command: `head -n 20`

4. **Show the last 15 lines of the file `server.log`.**  
   Command: `tail -n 15`

5. **View the contents of the file `server_status.txt` in reverse order (starting from the last line).**  
   Command: `tac`
