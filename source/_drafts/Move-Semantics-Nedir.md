---
title: Move Semantics Nedir?
lang: tr
tags:
 - c++
 - c++11
 - std::move
 - Move Semantics
 - lvalue
 - rvalue
---
C++11 ile birlikte gelen belkide en dikkat çekici özelliklerden birisi rvalue düzenlemesidir. Öncelikli olarak lvalue ve rvalue nedir ne işe yarar nerede kullanılır incelemek gerekiyor.
Tam olarak ne olduklarını, nasıl çalıştıklarını anlatmak ve anlamak o kadar kolay olduğu söylenemez. lvalue en basit ve genel tabiri ile herhangibir ismi olan, istediğiniz zaman erişebildiğiniz değişkenlerdir.

{% codeblock lang:cpp %}
    char* text = "text";
    std::string str = "str";
    int total = 10;
    double size = 1.22;
    std::vector<int> items;
    int sum = total + 123;

    int a = (321 + 123) * 2;
    int b = 10 * 20;
    int c = a + b;
{% endcodeblock %}

Bütün bu değişkenler lvalue tipindedir. text, str, total, size, items ve sum değişkenleri içerilerinde veri tutmakta ve istediğimiz zaman o bilgilere erişip düzenleme yapabiliriz. Atama işlemlerinin sol tarafında ki değişkenler her zaman(küçük bir istisna var sadece) **lvalue** tipindedir ve lvalue açılımı **left value** demektir.

rvalue tipi ise anlık olarak hafıza oluşturup daha sonra silinen verilerdir. **right value**'un kısaltılmasıdır ve atama işlemlerinin sağ tarafında yer alan değerlerdir. lvalue tersi olarak atama işlemi yapamazsınız (küçük bir istisna var).

Örnekte ki **(321 + 123) * 2**, **10*10**, **a + b** anlık olarak oluşturulmakta ve değişkene atanmaktadır. Bu atama işlemleri copy constructor yada assignment operator çağrımı yapılmakta.
rvalue çıkış amacı performans sorunlarını ortadan kaldırmaktadır. Fazladan kopyalama işlemlerini yapmasına engel olarak sadece taşıma işlemi ile atama işlemini tamamlamak.

Şu ana kadar yaptığımız atama işlemleri için referans sembolü (**&**) kullanıyorduk ve bunu lvalue atamalarında kullanıyoruz. rvalue için ise yeni bir sembol eklendi. **&&** ile rvalue referanslarını kullanabiliyoruz. Çok bir fark yok gibi görünüyor olsada aslında oldukça önemli bir gelişme.

{% codeblock lang:cpp %}
#include <stdio.h>
#include <iostream>

void print(int & i)
{
    std::cout << i << ", lvalue" << std::endl;
}

void print(int && i)
{
    std::cout << i << ", rvalue" << std::endl;
}

vois main(int argc, char *argv[])
{
    int i = 20;
    print(i);
    print(10);
}
{% endcodeblock %}
{% codeblock %}
20, lvalue
10, rvalue
{% endcodeblock %}