## About this Project
This is a revival of Batsh.

#### Refer to the following links for further information:

##### Explanation: https://discuss.ocaml.org/t/compiling-batsh/4700

Original Project: https://github.com/BYVoid/Batsh

Original Dependency: https://github.com/BYVoid/Dlist

Revived Project: https://github.com/darrenldl/Batsh

Revived Dependency: https://github.com/darrenldl/Dlist

Online Interpreter: https://batsh.org/


# Batsh

Batsh is a simple programming language that compiles to [GNU Bash](https://www.gnu.org/software/bash/) and [Windows Batch](http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/batch.mspx).
It enables you to write your script once, which then runs on all platforms without **any** additional dependency.

Both Bash and Batch are messy to read and tricky to write due to historical reasons.
You have to spend a lot of time learning either of them and write platform-dependent code for each operating system.
I have wasted lots of time in my life struggling with bizarre syntaxes and unreasonable behaviors of them, and do not want to waste any more.

If you happen to be a maintainer of a cross-platform tool which relies on Bash on Linux/Mac and Batch on Windows as "glue code", and found it painful to "synchronize" between them, you would definitely like to try Batsh.

## Trying it
[Online Interpreter](http://batsh.org/)

## Getting it
```docker
docker pull akito13/batsh:0.0.7
```

## Building it
```docker
docker build -t self/batsh:0.0.7 -f Dockerfile .
```

## Syntax

The syntax of Batsh is [C-based](https://en.wikipedia.org/wiki/List_of_C-based_programming_languages) (derived from C programming language).
If you have learned C, Java, C++ or JavaScript, Batsh is quite easy for you.

### Assignment

```javascript
a = 1;
b = "string";
c = [1, 2, "str", true, false];
```

### Expression

```javascript
a = 1 + 2;
b = a * 7;
c = "Con" ++ "cat";
d = c ++ b;
```

### Command

```javascript
// On UNIX
output = ls();
// On Windows
output = dir();
// Platform independent
output = readdir();

// Test existence
ex = exists("file.txt");
```

### If condition

```javascript
a = 3;
if (a > 2) {
  println("Yes");
} else {
  println("No");
}
```

### Loop

```javascript
// Fibonacci
n = 0;
i = 0;
j = 1;
while (n < 60) {
  k = i + j;
  i = j;
  j = k;
  n = n + 1;
  println(k);
}
```

### Function

```javascript
v1 = "Global V1";
v2 = "Global V2";
function func(p) {
  v1 = "Local " ++ p;
  global v2;
  v2 = "V2 Modified.";
}
func("Var");
```

### Recursion

```javascript
function fibonacci(num) {
  if (num == 0) {
    return 0;
  } else if (num == 1) {
    return 1;
  } else {
    return (fibonacci(num - 2) + fibonacci(num - 1));
  }
}
println(fibonacci(8));
```


### Syntax Highlighting

* [vim-Batsh](https://github.com/vuryleo/vim-Batsh)

## Built-in functions

In order to make script cross-platform, Batsh provided some "built-in" functions that will compile to platform-dependent code. It is assumed that Bash script runs on Linux or Mac OS and Batch script runs on Windows (XP or higher), which means Cygwin or wine are not supported.

### `print(text, ...)`

Prints a text string to console without a newline.

### `println(text, ...)`

Prints a text string to console with a new line (LF for bash, CRLF for batch).

### `call(path, arg, ...)`

Runs command from path through shell.

### `bash(rawStatement)`

Put `rawStatement` into compiled code for Bash. Ignore for Windows Batch.

### `batch(rawStatement)`

Put `rawStatement` into compiled code for Windows Batch. Ignore for Bash.

### `readdir(path)`

Equals to `ls` and `dir /w`.

### `exists(path)`

Test existence of given path. 

## Command Line Usage

```
NAME
       batsh - A language that compiles to Bash and Windows Batch.

SYNOPSIS
       batsh COMMAND ...

COMMANDS
       bash
           Compile to Bash script.

       batsh
           Format source file.

       winbat
           Compile to Windows Batch script.

OPTIONS
       --help[=FMT] (default=pager)
           Show this help in format FMT (pager, plain or groff).

       --version
           Show version information.
```

## Why not Python/Ruby/Node.js/Lua

Yes you can use any of them as platform-independent glue code. But there are several disadvantages:

1. None of them is **preinstalled on all platforms** (including Windows).
2. Functionalities like process piping are not convenient to use.
3. Hard to integrate with existing code written in Bash or Batch.