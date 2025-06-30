# 🔐 Caesar Cipher in NASM x86 Assembly

> A low-level implementation of one of the oldest ciphers in cryptography, developed as a semester project for **CS-235: Computer Organization and Assembly Language (COAL)** under **Engr. Muhammad Abid Hussain** at **NUST Balochistan Campus (NBC), Quetta**.

---

## 📌 Overview

This project implements the **Caesar Cipher** encryption and decryption algorithm using **NASM x86 Assembly Language** on Linux. It showcases direct system-level I/O operations and string manipulation through interrupts (`int 0x80`).

---

### 📖 Contents

* [💡 Motivation](#-motivation)
* [📚 Background Knowledge](#-background-knowledge)
* [❓ Problem Statement](#-problem-statement)
* [🎯 Objectives](#-objectives)
* [⚙️ Program Structure](#-program-structure)
* [🔧 Subroutines](#-subroutines)
* [🔁 Caesar Cipher Logic](#-caesar-cipher-logic)
* [✨ Features](#-features)
* [⚠️ Limitations](#-limitations)
* [▶️ How to Run](#-how-to-run)
* [📥 Clone This Project](#-clone-this-project)
* [👥 Contributors](#-contributors)
* [📚 References](#-references)

---

## 💡 Motivation

The Caesar Cipher was chosen for its:

* Simplicity in concept yet depth in implementation
* Educational value in practicing ASCII arithmetic and modular logic
* Potential to build foundational knowledge for more advanced ciphers

The project emphasizes **hands-on understanding** of system-level programming with real-time user interaction.

---

## 📚 Background Knowledge

Understanding this project requires familiarity with:

* **NASM Assembly Language**: register-based logic, memory addressing
* **Linux syscalls**: low-level I/O using `int 0x80`
* **ASCII encoding**: converting and wrapping character codes
* **Modular Arithmetic**: cyclic shift logic

---

## ❓ Problem Statement

> Design a user-interactive Caesar Cipher tool in NASM x86 that:
>
> * Takes text and shift value as input
> * Allows mode selection (Encrypt or Decrypt)
> * Preserves letter casing
> * Outputs processed result using Linux syscalls

---

## 🎯 Objectives

* Write clean, structured x86 NASM code
* Master input/output via Linux system calls
* Handle strings, loops, and modular logic in low-level language
* Strengthen understanding of encryption basics

---

## ⚙️ Program Structure

**1. `.data` Section:** Contains prompt strings, labels, error messages.

**2. `.bss` Section:** Uninitialized memory for:

* User input (shift value, text)
* Mode selection (E/D)
* Output buffer

**3. `.text` Section (Main Logic):**

* Read mode input (E/D)
* Read and convert shift value from ASCII
* Get input text
* Apply Caesar logic per character
* Display result or error

---

## 🔧 Subroutines

### 🔹 `str_to_int`

* Converts ASCII numeric string to integer
* Detects invalid or negative input

### 🔹 `print_string`

* Dynamically calculates string length
* Displays result using syscall 4 (`write`)

---

## 🔁 Caesar Cipher Logic

**Encryption**:

* For `A-Z`: `(char - 'A' + shift) % 26 + 'A'`
* For `a-z`: `(char - 'a' + shift) % 26 + 'a'`

**Decryption**:

* Replace `+ shift` with `- shift` in formula

**Other characters** remain unchanged.

---

## ✨ Features

✅ Interactive user prompts
✅ Encryption and decryption modes
✅ Case-sensitive letter handling
✅ Syscall-based I/O only (no C libs)
✅ Newline and invalid input handling
✅ Buffer reset between runs

---

## ⚠️ Limitations

⚠️ Shift must be a **positive integer < 256**
⚠️ No handling for punctuation or symbols
⚠️ No input protection against alphabetic characters in shift

---

## ▶️ How to Run

> 🛠 Requirements: Linux environment (or WSL), NASM assembler

```bash
nasm -f elf32 caesar_cipher.asm -o caesar_cipher.o
ld -m elf_i386 caesar_cipher.o -o caesar_cipher
./caesar_cipher
```

You will be prompted to:

* Enter `E` or `D`
* Provide a shift value
* Input the text for transformation

---

## 📥 Clone This Project

```bash
git clone https://github.com/SameerTalreja/CeaserCipher_in_NASMAssembly_CoalProject.git
cd CeaserCipher_in_NASMAssembly_CoalProject
```

---

## 👥 Contributors

| 👨‍💻 Name       | 🌐 GitHub                                                |
| -------------  | -------------------------------------------------------- |
| Sameer Talreja | [@SameerTalreja](https://github.com/SameerTalreja)       |
| Abdul Basit    | [@AbdulBasit](https://github.com/BasitAchak)             |


> 🔁 Feel free to fork, clone, or contribute!

---

## 📚 References

* [NASM Documentation](https://www.nasm.us/doc/)
* [Linux syscall man page](https://man7.org/linux/man-pages/man2/write.2.html)
* [Wikipedia: Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
* [GeeksForGeeks: Caesar Cipher](https://www.geeksforgeeks.org/caesar-cipher-in-cryptography/)
* [CaesarCipher.com](https://caesar-cipher.com/)
* [YouTube: Assembly Caesar Cipher](https://www.youtube.com/watch?v=JtbKh_12ctg)

---

> 🏁 *“Turning theory into hardware-near implementation—one opcode at a time.”*
