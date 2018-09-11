---
layout: post
title:  My way for C programming
date:   2018-09-05
categories: programming C code coding tdd oop
---

These notes are intended to describe my habits in writing C codes as I sometimes need to pass them to collaborators.

## Disclaimer
C is my favourite programming language and I use it for my projects ([SSSim](https://ans.disi.unitn.it/redmine/projects/sssim), [PeerStreamer-ng](https://github.com/netCommonsEU/PeerStreamer-ng), [PeerStreamer-engine](https://github.com/netCommonsEU/PeerStreamer-engine)). 
With time I developed a personal style for coding in C and a strong polarized ideology on how to program properly.
However, knowing in the end it just boils down to a matter of taste, I strongly believe I can happily change my mind if somebody shows me better and more elegant ways to do things.

## Coding Style and Naming Conventions
I generally follow the [linux kernel guidelines](https://www.kernel.org/doc/html/v4.10/process/coding-style.html) for style and naming conventions.
It seems a pretty neat thing to do and there is a huge (and valuable) community agreeing on that.

Long story short, function and structure names go lower case with words separated by "_".

## Project Design
First comes the design. 
It is important to describe with words (even few, concise but effective) the desired behaviour of the software, optionally listing the features.
Algorithms should be described with a flow-chart (even at a high level) and systems with a class-diagram (see [this submodule](https://ans.disi.unitn.it/redmine/projects/peerstreamer-ng/wiki/Network_layer) as an example).

## Object as a Design Pattern
Despite C does not provide objects at language level it is pretty handy to think a code with objects in mind (I guess it is more natural for people).
Objects are in C a design pattern like an _observer_ or a _factory_ would be in C++.

An object, being a data type, is characterized by some attributes (variables) and some related operations (functions).

Typically, that is realized with _struct_ and related functions.

{% include open_collapsable_code.html %}
struct my_obj {
        double num;
        int id; 
};

int my_obj_init(struct my_obj *o)
{
	int res = -1;  // default return value (error)

	if (o) {  // robust code here!
		o->num = 0;
		o->id = 42;
		res = 0;  // everything went good (success to be return)
	}

	return res;
}

struct my_obj * my_obj_new()
{
	struct my_obj * o;

	o = malloc(sizeof(struct my_obj));

	if (o && my_obj_init(o) == 0)
		return o;
	else
		return NULL;
}

void  my_obj_destroy(struct my_obj ** o)  // everything malloc'd must be deallocated!!
{
	if (o && *o) {
		free(*o);
		*o = NULL; // this avoids double free
	}
}

int my_obj_id(struct my_obj *o)
{
	if (o)
		return o->id;
	return -1;
}

int my_obj_inc(struct my_obj * o)
{
	int res = -1;

	if (o) {
		o->num++;
		res = 0;
	}

	return res;
}
{% include close_collapsable_code.html %}

The main features of object oriented programming are:
 * Encapsulation;
 * Inheritance;
 * Polymorphism.

One can implement them as they are needed by the program.

### Encapsulation
Encapsulation means the object attributes are not directly accessible by no one else but the object instance itself.

To implement this feature I generally define the struct in a .c file and I just declare it in the header .h file.

{% include open_collapsable_code.html %}
#ifndef __MY_OBJ_H__

#define __MY_OBJ_H__

struct my_obj;

struct my_obj * my_obj_new();

void  my_obj_destroy(struct my_obj ** o);

int my_obj_id(struct my_obj * o);

int my_obj_inc(struct my_obj * o);

#endif
{% include close_collapsable_code.html %}

Note that the header file .h represents the API of the object to expose, in the previous example we omitted to include my_obj_init as we want the other modules just to interact with the function my_obj_new for the object initiazialization.
(This is also needed as an external module cannot malloc a struct my_obj as its definition is _opacque_)


### Inheritance
Inheritance is about having an object whose definition relies on another class and hence it borrows some of the latter behaviour.
Inheritance is generally deprecated in object oriented programming as it makes programs more rigid than having simple reference relationships.
Inheritance makes an object be in a _is a_ relationship with another, e.g., an apple is a fruit.
Anyway, it sometimes is useful.

{% include open_collapsable_code.html %}
struct my_derived_obj {
	struct my_obj o;  // we include the base object as the first attribute
	int foo;
}

struct my_derived_obj * my_derived_obj_new()
{
	struct my_derived_obj * do;
	struct my_obj * o;

	do = malloc(sizeof(struct my_obj));
	do->foo = -1;
	o = (struct my_obj *) do;  // cast of the pointer to the base object

	my_obj_init(o);

	return do;
}

int my_derived_obj_id(struct my_derived_obj * do)
{
	return my_obj_id((struct my_obj *) do);	 // Inheritence magic
}

{% include close_collapsable_code.html %}

### Polymorphism
Polymorphic code is used whenever we expect different behaviours to be executed by the same code.
It can be obtained using inheritance or interfaces.
I generally prefer the interface approach as it is more lightweight and dynamic but that does not allow easily the handling of ancillary data.
I.e., if the polymorphic behaviour depends on variables specific for each cases, then inheritance works better.

 * Polymorphism with inheritance (good when behaviour depends on different, non overlapping sets of attributes);

{% include open_collapsable_code.html %}
typedef int (*my_fun_t)(struct my_obj * o);  // we save space defining the function prototype here

int my_obj_fun(struct my_obj * o)
{
	int res = -1;

	if (o) {
		printf("I am base fun\n");
		res = 0;
	}
	
	return res;
}

int my_derived_obj_fun(struct my_obj * o)
{
	struct my_derived_obj * do;
	int res = -1;

	if (o) {
		do = (struct my_derived_obj *) o;
		printf("I am derived fun, bar: %d\n", do->bar);  // this functions relies on ancillary data specific of the derived object case
		res = 0;
	}
	
	return res;
}

struct my_obj {
	my_fun_t foo;
};

struct my_obj * my_obj_new()
{
	struct my_obj * o;

	o = malloc(sizeof(struct my_obj));
	o->foo = my_obj_fun;

	return o;
}

struct my_derived_obj {
	struct my_obj o;
	int bar;  // this is the ancillary data I was mentioning previously
};

struct my_derived_obj * my_derived_obj_new()
{
	struct my_derived_obj * do;

	o = malloc(sizeof(struct my_derived_obj));
	((struct my_obj *)o)->foo = my_derived_obj_fun;
	o->bar = 42;

	return o;
}

// Sample use code

int main(int argv, char** argc)
{
	int i;
	struct my_obj *objs[2];  // array of all objects

	objs[0] = my_obj_new();  // I can put base objects...
	objs[1] = (struct my_obj*) my_derived_obj_new();  // ..as well as derived ones

	for(i=0; i<2; i++)
		(objs[i])->foo(objs[i]);  // polymorphic code behaviour depends on data initialization

	return 0;
}
{% include close_collapsable_code.html %}

* Polymorphism with interfaces (my favourite choice for plug-ins).

{% include open_collapsable_code.html %}
typedef void (*my_fun_t)(void);  // we save space defining the function prototype here

struct my_obj {
	my_obj_itx * itx;
};

struct my_obj_itx {  // our interface definition
	my_fun_t print_something;
};

struct my_obj_itx itx_num1 = {  // our interface implementation number 1
	.print_something = print1;
};

struct my_obj_itx itx_num2 = {  // our interface implementation number 2
	.print_something = print2;
};

void print1()
{
	printf("I'm NUMBER ONE :)\n");
}

void print2()
{
	printf("I'm number two :(\n");
}

struct my_obj * my_obj_new(int num)
{
	struct my_obj * o;

	o = malloc(sizeof(struct my_obj));
	swtich(num) {
		case 1:
			o->itx = &itx_num1;
			break;
		case 2:
			o->itx = &itx_num2;
			break;
		default:
			o->itx = NULL;
	}
	return o;
}

void my_obj_print_something(struct my_obj *o) 
{
	if (o) 
		o->itx->print_something();  
}

// Sample use code

int main(int argv, char** argc)
{
	int i;
	struct my_obj *objs[2];  // array of all objects

	objs[0] = my_obj_new(1);  // object with interface 1
	objs[1] = my_obj_new(2);  // object with interface 2

	for(i=0; i<2; i++)
		my_obj_print_something(&objs[i]);  // polymorphic code behaviour depends on data initialization

	return 0;
}
{% include close_collapsable_code.html %}

## Test Driven Development

Tests are of maximum importance, they help to write robust code during development and, when merging changes, they can be used for regression tests, assessing all the code invariants are consistent.

In the following, 
* a __test case__ is a C function performing a test;
* a __unit test__ is a collection of functions testing one single C module (a .c file);
* a __regression test__ is the process of running the whole set of available test cases and check for code consistency.

I identify few major important test features:
 * As tests are supposed to debug complex code, they __must__ be very clear and simple to understand (otherwise one would need tests for the test cases);
 * Each test function should clearly focus on one aspect of the program and have a relatable name;
 * Test should not be interactive (no input or interaction required) and give a concise, standardized response (success/failure).
In this way, one can run the provided bunch of test cases and get immediately if the code is ok without a deeper understanding of them.

{% include open_collapsable_code.html %}

#include &lt;assert.h>
#include &lt;stdio.h>

#include &lt;my_obj.h>  // we test against the public API of my_obj module

void my_obj_new_test()  // this function is a test case for my_obj_new()
{
	struct my_obj * o = NULL;

	o = my_obj_new(1);  // common case 1
	assert(o);  // if "o" is NULL this fails and the test crashes
	my_obj_destroy(&o);  // we cleanup 

	o = my_obj_new(2);  // common case 2
	assert(o);  // if "o" is NULL this fails and the test crashes
	my_obj_destroy(&o);  // we cleanup 

	o = my_obj_new(3);  // WRONG parameter value
	assert(o == NULL);  // This should in principle not being a valid object

	fprintf(stderr,"%s successfully passed!\n",__func__); // this line confirms this function worked
}

int main(int argv, char ** argc)
{
	my_obj_new_test();  
	my_obj_destroy_test();  
	my_obj_inc_test();  
	return 0;
}

{% include close_collapsable_code.html %}

Note that test cases help identifying a consistent behaviour for our software.
The previous test case example imposes that when a value different from "1" or "2" is passed to my_obj_new, it does not create an object as the value is not valid.

Depending on the parameter type testing values change accordingly; one should always test corner cases, e.g.:
 * 0, -1, 90000 for int
 * NULL, "", "random" for string
 * etc..

The rule of thumb is __always testing the public API against few valid cases and all the invalid cases__.

The previous example code can be compiled in an executable; I generally use this makefile

{% include open_collapsable_code.html %}

SRC=$(wildcard *.c)
OBJS=$(SRC:.c=.test)

TARGET_SRC += $(wildcard ../src/*.c) 
TARGET_OBJS=$(TARGET_SRC:.c=.o)

CFLAGS += -g -W -Wall -Wno-unused-function -Wno-unused-parameter -O0 

all: $(TARGET_SRC) $(TARGET_OBJS) $(OBJS)

%.test: %.c $(TARGET_OBJS) 
	$(CC) -o $@ $< $(CFLAGS) $(TARGET_OBJS) $(LDFLAGS)

clean:
	rm -f *.test 

.PHONY: all clean

{% include close_collapsable_code.html %}

### Test Execution

Executing a test program validates our code for a unit test. 
However, it does not reveal if any nasty memory misuse is in place.
We can run the test program with [valgrind](http://valgrind.org/) to detect memory flaws and debug our program.

I use the following script (with fancy colors) to automatically execute all the tests and check for memory leaks (note valgrind is supposed to be already installed):

{% include open_collapsable_code.html %}

#!/bin/bash

info() {
	echo -e "\E[33m$@\033[0m"
}

error() {
	echo -e "\E[31m$@\033[0m"
}

success() {
	echo -e "\E[32m$@\033[0m"
}

TDIR="$(dirname $0)"
FILES=(`ls $TDIR/*.test`)
i=0
while [ $i -lt ${#FILES[@]} ]; do
	info "Running ${FILES[$i]}"
	res=$(${FILES[$i]} 2>&1)
	if [ $? -ne 0 ]; then
		error "$res"
		exit 1
	fi
	info "Valgrind on ${FILES[$i]}"
	res=$(valgrind --leak-check=full ${FILES[$i]} 2>&1 | awk '/ERROR SUMMARY/ {print $4}')
	if [ $res -gt 0 ]; then
		error "Memory error on ${FILES[$i]}"
		error $(valgrind --leak-check=full ${FILES[$i]})
		exit 1
	fi
	success "Test Passed"
	i=$((i+1))
done

{% include close_collapsable_code.html %}
