---
title: Move Semantics Nedir?
tags:
 - c++
 - c++ 11
 - std::move
 - Move Semantics
 - lvalue
 - rvalue
---
C++ 11 ile birlikte gelen belkide en dikkat çekici özelliklerden birisi rvalue düzenlemesidir. Öncelikli olarak lvalue ve rvalue nedir ne işe yarar nerede kullanılır incelemek gerekiyor.
Tam olarak ne olduklarını, nasıl çalıştıklarını anlatmak ve anlamak o kadar kolay olduğu söylenemez. lvalue en basit ve genel tabiri ile herhangibir ismi olan, istediğiniz zaman erişebildiğiniz değişkenlerdir.

{% codeblock lang:cpp %}
    char* text = "text";
    std::string str = "str";
    int total = 10;
    double size = 1.22;
    std::vector<int> items;
    int sum = total + 123;
{% endcodeblock %}

Bütün bu değişkenler lvalue tipindedir. text, str, total, size, items ve sum değişkenleri lvalue olarak istediğiniz zaman ulaşabilirsiniz. İstediğiniz zaman değiştirebilirsiniz.

rvalue tipi ise anlık olarak hafıza oluşturup daha sonra silinen verilerdir. lvalue tersi olarak atama işlemi yapamaz, sadece okuyabilirsiniz.

{% codeblock lang:cpp %}
    int a = (321 + 123) * 2;
    int b = 10 * 20;
    int c = a + b;
{% endcodeblock %}

Burada ki **(321 + 123) * 2**, **10*10**, **a + b** anlık olarak oluşturulmakta ve değişkene atanmaktadır. Bu atama işlemleri copy constructor çağrımı yapılmakta.
