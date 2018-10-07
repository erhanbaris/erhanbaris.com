---
title: My new Open Source project simple_hash
tags:
  - C
  - C++
  - simple_hash
  - SymSpellPlusPlus
  - HashSet
  - HashMap
  - Open Source
  - GitHub
lang: en
date: 2018-10-07 20:40:04
---

I have been working on SymSpell project for uprading newer version. I did a lot of changes and I supposed to it will be faster than previous version. Yes it have been faster than previous version but problem is that it was slower than original version. Also original version have been writtern in C#. It is working faster than my implementation and it was make me very upset. Because everybody knows C/C++ is quite faster than c# and I got fail to make it.

I checked all codes line by line for finding problem with my code. Everything looks nice but there was a very big problem. Adding keys and searching was taking much time. Standard library is not fast enough as expected. It provides more portability on operating system and compilers but not it does not fast. Than I used my old friend Google hashmap and it was good enough but still was slower than original code.

Whan I told to my friend, he told to me "Why don't you use just C for resolving this problem?" than I searched open source project for hashmap and hashset. Finally I found one project ın github but it is only support hashset. Also it had some limitation like using string as key. I decited to change his source code to my requirements and added new features to it.

Now I glad to show my new github project as **[simple_hash](https://github.com/erhanbaris/simple_hash)**. Very new project and I have made todo list for my future working. It is very simple but It good enough to using on small project.

Currently my **[SymSpellPlusPlus](http://github.com/erhanbaris/SymSpellPlusPlus)** application is faster than the original project :)

There are some examples:


## HashSet C Example

```c
    #include "simple_hash.h"

    unsigned int customHash(char* p, unsigned int key_len)
    {
        unsigned int hash = 0;
        for (; *p; ++p)
            hash ^= *p + 0x9e3779b9 + (hash << 6) + (hash >> 2);
        return hash;
    }

    char *foo = "foo";
    char *missing = "missing";
    hashset_t set = hashset_create();

    if (set == NULL) {
        fprintf(stderr, "failed to create hashset instance\n");
        abort();
    }

    hashset_set_hash_function(set, customHash);
    hashset_add(set, foo, strlen(foo));
    assert(hashset_is_member(set, foo, strlen(foo)) == 1);
    assert(hashset_is_member(set, missing, strlen(missing)) == 0);
    hashset_destroy(set);

```

## HashSet C++ Example

```c++
    #include "simple_hash.hpp"

    unsigned int customHash(char* p, unsigned int key_len)
    {
        unsigned int hash = 0;
        for (; *p; ++p)
            hash ^= *p + 0x9e3779b9 + (hash << 6) + (hash >> 2);
        return hash;
    }

    SimpleHashSet set;
    char *foo = "foo";
    char *missing = "missing";
    if (!set.status())
    {
        fprintf(stderr, "failed to create hashset instance\n");
        abort();
    }

    set.setHashFunction(customHash);
    set.add(foo);
    assert(set.exists(foo) == 1);
    assert(set.exists(missing) == 0);

```

## HashMap C Example 

```c
    #include "simple_hash.h"

    unsigned int customHash(char* p, unsigned int key_len)
    {
        unsigned int hash = 0;
        for (; *p; ++p)
            hash ^= *p + 0x9e3779b9 + (hash << 6) + (hash >> 2);
        return hash;
    }

    char *foo = "foo";
    char *bar = "bar";
    char *missing = "missing";
    hashmap_t map = hashmap_create();
    
    if (map == NULL) {
        fprintf(stderr, "failed to create hashmap instance\n");
        abort();
    }
    
    hashmap_set_hash_function(map, customHash);
    hashmap_add(map, foo, strlen(foo), bar);
    assert(hashmap_is_member(map, foo, strlen(foo)) == 1);
    assert(hashmap_is_member(map, missing, strlen(missing)) == 0);
    assert(strcmp((char*)hashmap_get(map, foo, strlen(foo)), bar) == 0);
    hashmap_destroy(map);

```

## HashMap C++ Example

```c++
    #include "simple_hash.hpp"

    unsigned int customHash(char* p, unsigned int key_len)
    {
        unsigned int hash = 0;
        for (; *p; ++p)
            hash ^= *p + 0x9e3779b9 + (hash << 6) + (hash >> 2);
        return hash;
    }

    SimpleHashMap<char> map;
    char *foo = "foo";
    char *bar = "bar";
    char *missing = "missing";
    if (!map.status())
    {
        fprintf(stderr, "failed to create hashset instance\n");
        abort();
    }

    map.setHashFunction(customHash);
    map.add(foo, bar);
    assert(map.exists(foo) == 1);
    assert(strcmp(map.get(foo), bar) == 0);

```


### Note for C++

As you can see map is only works with pointer. You have to define value type as type name not with pointer symbol at definition.
**SimpleHashMap<char\>** means that you want to store **char\*\***. So you should be careful when you want to use **SimpleHashMap**.