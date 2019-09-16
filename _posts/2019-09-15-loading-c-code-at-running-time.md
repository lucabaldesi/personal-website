---
layout: post
title: Loading C code (plugins) at running time
date:   2019-09-15
categories: programming C design pattern
---

Few years ago I stumbled upon this (well-established) technique for loading c-coded plugins at running time.
Since I recently had to recall these concepts but I could not easily find back the sources I decided to describe it in few notes.

### The problem

If you are designing a program to be highly modular, eventually you are gonna play with the idea to make it detect and load new parts at running time.
E.g., if your software offer the user several algorithms to perform a common task, you would like to write and touch the main program only once and focus on adding new features as separate modules.

In the following I refer to these additional modules as _plugins_.
These plugins are separated binary files that can be loaded and run by our software without any modification for the latter.

### The plugin

The plugin is a piece of code which implements some well defined interface.
For example, if our interface is made up by
  * a plugin name _PLUGIN-NAME_;
  * a function _speak_;

Our _doggy_ plugin is gonna look like these:

```
#include<stdio.h>

char PLUGIN_NAME[]="doggy";

void speak()
{
	printf("Woof woof!\n");
}
```

It is easy to imagine variations for this dumb example;

```
#include<stdio.h>

char PLUGIN_NAME[]="kitty";

void speak()
{
	printf("Meow meow!\n");
}
```

### The main program

Our platform must:
  1. check for available plugins;
  2. load their interface implementations;
  3. be able to execute their code.

It turns out it is quite simple, relying on ELF shared objects and the DL (dynamic linking, the one used with the _-ldl_ flag) library.

We can split the loading algorithm in two logic parts;
  1. list the shared object in the current directory;
  2. open and load the plugin code.

The function _opendir_ opens a location given as string and returns a handle _DIR_.
Once we have the DIR handle we can list the files in the directory calling _readdir_ until it returns _NULL_.
(Open directories must be closed with _closedir_).

To open a shared object file we use _dlopen_ which returns an opaque handler.
Once we have the handler we can request the plugin variables and functions by name using _dlsym_.
(Open shared object files must be closed with _dlclose_).

```
#include<stdio.h>
#include<dirent.h>
#include<libgen.h>
#include<string.h>
#include<dlfcn.h>


typedef void func_t(void);

int main(int argc, char **argv)
{
	char *pwd, *str_pos;
	DIR *pwdir;
	struct dirent* file;
	int len;
	void *plugin_handler;
	char path[512];
	func_t *f;

	printf("In main of %s\n", argv[0]);
	pwd = dirname(argv[0]);
	pwdir = opendir(pwd);

	while ((file=readdir(pwdir)))
	{
		len = strlen(file->d_name);
		if (strcmp(file->d_name+len-3, ".so")==0)
		{
			printf("found plugin file %s\n", file->d_name);
			sprintf(path, "%s/%s", pwd, file->d_name);

			plugin_handler = dlopen(path, RTLD_LAZY);
			str_pos = (char*) dlsym(plugin_handler, "PLUGIN_NAME");
			printf("Executing plugin %s\n", str_pos);
			f = (func_t*) dlsym(plugin_handler, "speak");
			f();  // here we call the plugin specific method!!
			dlclose(plugin_handler);
		}
	}
	
	closedir(pwdir);

	return 0;
}
```

The code above can be compiled with [meson](https://mesonbuild.com/) and the following _meson.build_ file:

```
project('plugin_fun', 'c')
dl = meson.get_compiler('c').find_library('dl')
executable('fun', 'main.c', dependencies : dl)
shared_library('doggy', 'doggy.c')
shared_library('kitty', 'kitty.c')
```
