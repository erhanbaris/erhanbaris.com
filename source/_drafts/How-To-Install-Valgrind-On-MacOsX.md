---
title: How To Install Valgrind On MacOsX
tags: 
 - C++
 - CPP
 - Valgrind
 - MacOsX
lang: en
---

I have been tested a lot of times to install Valgrind on MacOs and I always got problem. Finally I installed Valgrind without any problem.

It is very easy to install and I want to share with you. Because, Valgrind is wonderful application for detecting memory leak and profiling codes. In my opinion, every C++ developer should have Valgrind on their PC, if there using unix based OS.

***Requirements***
 - XCode
 - Git
 - root rights (just kidding)

***Installing***

{% codeblock %}
git clone git://sourceware.org/git/valgrind.git
cd valgrind
./autogen.sh
./configure
make
sudo make install
{% endcodeblock %}

If you get exception something like that:
{% codeblock %}
make[3]: Nothing to be done for `all-am'.
Making all in coregrind
make[2]: *** No rule to make target `/usr/include/mach/mach_vm.defs', needed by `m_mach/mach_vmUser.c'.  Stop.
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2
{% endcodeblock %}
it means you are not using latest version of XCode and you need to do execute following shell command.

{% codeblock %}
xcode-select --install
{% endcodeblock %}

and then execute ***make*** command again. That is all.

Let's do some small examples.
First we can profile codes line by line.

Create new C/C++ application for testing. I did it as symspelltest application.
{% codeblock %}
valgrind --tool=callgrind --simulate-cache=yes ./symspelltest
{% endcodeblock %}

Valgrind generate log file when execution finished.
I assume, you are already installed homebrew.
{% codeblock %}
brew install qcachegrind --with-graphviz
{% endcodeblock %}

Now, check call stacks.
{% codeblock %}
qcachegrind callgrind.out.212
{% endcodeblock %}