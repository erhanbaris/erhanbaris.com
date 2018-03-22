---
title: Object Oriented Nize Ne Gibi Yenilikler Getirdi?
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
    printf("Printing as animal\r\n");
    item.print_information();
    return 0;
}
{% endcodeblock %}

Sonuç:
{% codeblock %}
Printing as animal
Kilo: 40, size: 50
{% endcodeblock %}

Hımmm, sanki c ile c++ arasında çok fark yokmuş gibi görünüyor ama aslında bakacak olursanız c++ sınıf tanımlamasında bazı bilgilerin görünür olduğu anlaşılıyor. Bu da kapsüllemeyi bozan şeylerden birisi. Tabi bunu **pimpl** ile önüne geçilebilir ama genede dışarda bazı bilgileri bırakmış oluyor. Kapsülleme bakımından c, c++ oranla daha başarılı. 

Fakat unutmamak lazım c++ içerisinde public, private ve protected tanımlamaları bu sorunu çözmek için oluşturulmuş ve bunlarla soruna belli bir düzeyde çözüme kavuşturabiliyoruz.
OO dillerinin önerdiği kapsülleme zaten uzun bir süreden beri var olan bir özellik.

## Polymorphism
Kısacası nesnelerin birbiri yerine kullanılabilmesidir. Bunuda Interface yada Abtract sınıflar aracılığı ile yada function pointer ile işlemi yapacak olan metodun değiştirilebilmesidir. OO dil kullananların oldukça aşina olduğu bir durumdur. 

Peki bu işlemi c ile nasıl yapabiliriz?
{% codeblock lang:cpp %}
// animal.h
struct animal;
struct animal* create_animal(int size, int kilo);
void print_information(struct animal *);

struct dog;
struct dog* create_dog(int size, int kilo, int age);
void print_information(struct dog *);

{% endcodeblock %}

{% codeblock lang:cpp %}
// animal.c
#include "animal.h"
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

struct dog {
    int size;
    int kilo;
    int age;
};

struct dog* create_dog(int size, int kilo, int age)
{
    struct dog* item = (struct dog*)std::malloc(sizeof(struct dog));
    item->kilo = kilo;
    item->size = size;
    item->age = age;
    return item;
}

void print_information(struct dog * item)
{
    printf("Kilo: %i, size: %i, age: %i\r\n", item->kilo, item->size, item->age);
}

{% endcodeblock %}

{% codeblock lang:cpp %}
// main.c
#include "animal.h"
int main()
{
    struct dog* d = create_dog(50, 40, 50);
	struct animal* a = (struct animal*)d;
	
	printf("Printing as animal\r\n");
	print_information(a);

	printf("Printing as dog\r\n");
	print_information(d);
    return 0;
}
{% endcodeblock %}

Sonuç:
{% codeblock %}
Printing as animal
Kilo: 40, size: 50
Printing as dog
Kilo: 40, size: 50, age: 50
{% endcodeblock %}

Tamam belki o bu örnek o kadar kafanıza yatmadı. O zaman birde function pointer ile örnek yapalım.

{% codeblock lang:cpp %}
// myapi.h
struct MY_API {
    int(*calc)(int a, int y);
    void(*info)();
};

struct MY_API create_sum_calculator();
struct MY_API create_sub_calculator();
{% endcodeblock %}

{% codeblock lang:cpp %}
// myapi.c
#include "myapi.h"
int sum(int a, int y)
{
    return a + y;
}

int sub(int a, int y)
{
    return a - y;
}

void sum_info()
{
    printf("Sum\r\n");
}

void sub_info()
{
    printf("Sub\r\n");
}

struct MY_API create_sum_calculator()
{
    struct MY_API calc = { sum, sum_info };
    return calc;
}

struct MY_API create_sub_calculator()
{
    struct MY_API calc = { sub, sub_info };
    return calc;
}
{% endcodeblock %}

{% codeblock lang:cpp %}
// main.c
#include "Animal.h"
int main()
{
    struct MY_API sumCalc = create_sum_calculator();
    struct MY_API subCalc = create_sub_calculator();
    
    sumCalc.info();
    printf("2 + 5 = %i\r\n", sumCalc.calc(2,5));
    
    subCalc.info();
    printf("2 - 5 = %i\r\n", subCalc.calc(2, 5));
}
{% endcodeblock %}

Sonuç:
{% codeblock %}
Sum
2 + 5 = 7
Sub
2 - 5 = -3
{% endcodeblock %}

Burada da linux çekirdeğinde ki fs.h dosyasından bir kod parçası. Şu an ki versiyonda çok daha uzun.
{% codeblock lang:cpp %}
struct file_operations {
	int (*lseek) (struct inode *, struct file *, off_t, int);
	int (*read) (struct inode *, struct file *, char *, int);
	int (*write) (struct inode *, struct file *, const char *, int);
	int (*readdir) (struct inode *, struct file *, void *, filldir_t);
	int (*select) (struct inode *, struct file *, int, select_table *);
	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
	int (*mmap) (struct inode *, struct file *, struct vm_area_struct *);
	int (*open) (struct inode *, struct file *);
	void (*release) (struct inode *, struct file *);
	int (*fsync) (struct inode *, struct file *);
	int (*fasync) (struct inode *, struct file *, int);
	int (*check_media_change) (kdev_t dev);
	int (*revalidate) (kdev_t dev);
};
{% endcodeblock %}

Sonuç gösteriyor ki polymorphism'de c dili için sorun değil. Tabi bunu yapabilmek için değişken tanımlamalarımızı aynı sıra ile ve türlerinin de aynı olması gerekiyor. RAM'da her iki nesnenin değişkenleri aynı sırada ve boyutta(türde) olması gerekiyor.
Ayrıca c++ arkaplanında buna benzer bir mekanizma kullanmaktadır. Virtual olarak tanımladığınız metodlar vtable isimli bir yerde tutulur ve çağrım yağtığınızda function pointer okunarak çalıştırılır. Yani c++ bu işlemleri sizin yerinize otomatik olarak yapar. Bu da hata yapma ihtimalinizi azaltır.

## Inheritance

#### HENÜZ YAZILMADI. YAZIYORUM.


### Peki bütün bunlar zaten var ise bize ne gibi bir faydası dokundu?
- Öncelikle daha güvenli bir geliştirme ortamı sağladı. Üst kısımda göstermiş olduğum bir çok şeyde hata yapma riski yüksek ve eğer hata yapılırsa bulunmasıda zor.
- Yazılım geliştirmeyi daha kolay hale getirdi.
- Nesneler arasında ki ikişki ve iletişimi daha anlaşılır kıldı.
Eminim ki daha bir çok faydası var fakat hepsini sıralamak olanaksız.

OO diller bize vaat ettiği kadar yenilik sunmasada sağlamış olduğu esneklik bile kullanımı için yeterli gibi duruyor.

