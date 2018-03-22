---
title: OO bize ne gibi yenilikler getirdi?
lang: tr
tags:
 - OO
 - C
 - C++
---
Genel olarak bütün dillere baktığımız üç ana kısıma ayrılıyor,
- Structured
- Object Oriented
- Functional

Ortaya çıkış sürelerine baktığımız zaman birbirlerine oldukça yakın olarak 1950-1960 civarında ortaya çıktı fakat son bir kaç yılda OO dillerin popüleritesi ve genel çevre tarafından görmüş olduu destek diğer bütün yapılara nazaran kat be kat arttı.
Özellikle C++, C# ve Java gibi dillerin sunmuş olduğu bu olanaklar programcıların aklını çelmekte kendi içinde bir gruplaşmalara bile sebep olmakta.

Peki OO dillerin bize tam olarak vaat ettiği nedir? Neden bizim için bu kadar önemli, kolay ve kullanışlılar. 
Bir çok farklı kişi buna farklı cevaplar verebilir. **Objeleri daha iyi yönetebilmek**, **gerçek dünyayı simule edebilmek**, **daha iyi yapılar oluşturabilmek** vs gibi bu liste uzayıp gider. Fakat OO dillerin aslında çözüm olarak sunduğu şeyler 3 tanedir. 
- Encapsulation
- Polymorphism
- Inheritance

Bu 3 madde şu anda heryerde gözümüze sokulan, sürekli olarak anlatılan ve bize nimetlerinden sürekli olarak bir sihir gibi söz edilen şeyler gerçektende vaat edilkdiği gibi OO diller ile mi birlikte geldi? Bunları sadece OO diller aracılığı ile mi kullanabiliriz? Peki OO diller olmasaydı bunlara ihtiyacımızda olmayacakmıydı?

## Encapsulation
En basit anlatımıyla sınıf içerisinde ki bilgilerin diğer kullanıcılar ve yapılardan saklanması ve tam bir yalıtılmışlık sağlama olarak tanımlanabilir. Dışarıya sadece bir erişim metodu(function pointer) yada sınıfı(abstract class) verilerek asıl yapının diğer dış erişimlere kapatılarak daha esnek değişiklikler, düzenlemeler yapılmasına imkan vermek için kullanılır. Kodun düzenlenmesi sonrasında o kodu kullanan diğer bütün yapının tekrardan derlenmesinin önüne geçilerek sadece değişikliğin olduğu kısmın derlenmesini sağlamaktır.

C dili için örnek göstermek gerekirse;
{% codeblock lang:cpp %}
// animal.h
struct animal;
struct animal* create_animal(int size, int kilo);
void print_information(struct animal *);

{% endcodeblock %}

{% codeblock lang:cpp %}
// animal.c
#include "Animal.h"
struct animal {
    int size;
    int kilo;
};

struct animal* create_animal(int size, int kilo)
{
    struct animal* item = (struct animal*)std::malloc(sizeof(struct animal));
    item->kilo = kilo;
    item->size = size;
    return item;
}

void print_information(struct animal * item)
{
    printf("Kilo: %i, size: %i\r\n", item->kilo, item->size);
}

{% endcodeblock %}

{% codeblock lang:cpp %}
// main.c
#include "Animal.h"
int main()
{
    struct animal* item = create_animal(50, 40);
    print_information(item);
    return 0;
}
{% endcodeblock %}

Aynı örneğin C++ ile gösterimi;
{% codeblock lang:cpp %}
// animal.hpp
class Animal {
public:
    Animal(int size, int kilo);
    void print_information();

private:
    int psize;
    int pkilo;
};

{% endcodeblock %}

{% codeblock lang:cpp %}
// animal.cpp
#include "Animal.hpp"
Animal::Animal(int size, int kilo)
{
    this->psize = size;
    this->pkilo = kilo;
}

void Animal::print_information()
{
    printf("Kilo: %i, size: %i\r\n", this->pkilo, this->psize);
}

{% endcodeblock %}

{% codeblock lang:cpp %}
// main.c
#include "Animal.hpp"
int main()
{
    Animal item(50,40);
    item.print_information();
    return 0;
}
{% endcodeblock %}

Hımmm, sanki c ile c++ arasında çok fark yokmuş gibi görünüyor ama aslında bakacak olursanız c++ sınıf tanımlamasında bazı bilgilerin görünür olduğu anlaşılıyor. Bu da kapsüllemeyi bozan şeylerden birisi. Tabi bunu **pimpl** ile önüne geçilebilir ama genede dışarda bazı bilgileri bırakmış oluyor. Kapsülleme bakımından c, c++ oranla daha başarılı. 

Fakat unutmamak lazım c++ içerisinde public, private ve protected tanımlamaları bu sorunu çözmek için oluşturulmuş ve bunlarla soruna belli bir düzeyde çözüme kavuşturabiliyoruz.
OO dillerinin önerdiği kapsülleme zaten uzun bir süreden beri var olan bir özellik.

## Polymorphism
Kısacası nesnelerin birbiri yerine kullanılabilmesidir. Bunuda Interface yada Abtract sınıflar aracılığı ile yada function pointer ile işlemi yapacak olan metodun değiştirilebilmesidir. OO dil kullananların oldukça aşina olduğu bir durumdur. 

Peki bu işlemi c ile nasıl yapabiliriz?

## Inheritance

