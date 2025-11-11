# Git Command Clone

This project implements **Pushy**, a lightweight version control system inspired by Git, written in **Shell Script**.  
Test cases are included to validate the correctness of each implemented feature.

---

## Available Commands

### **1. `pushy-init`**
Creates an empty Pushy repository.

---

### **2. `pushy-add <filenames...>`**
Adds the contents of one or more files to the index (staging area).

---

### **3. `pushy-commit [-a] -m <message>`**
Saves a copy of all files in the index to the repository.

**Options:**
- `-a` — Automatically stages all files already in the index by updating them with the current directory versions before committing.  
- `-m` — Specifies the commit message.

---

### **4. `pushy-log`**
Displays a list of all commits made to the repository, one per line.

---

### **5. `pushy-show [commit]:<filename>`**
Prints the contents of the specified file as of the given commit.

---

### **6. `pushy-rm [--force] [--cached] <filenames...>`**
Removes files from the index and/or the working directory.

**Options:**
- `--cached` — Removes the file only from the index (keeps it in the working directory).  
- `--force` — Forces removal even if it would result in data loss.

---

### **7. `pushy-status`**
Shows the status of files in:
- the current working directory  
- the index (staging area)  
- the repository (committed files)
