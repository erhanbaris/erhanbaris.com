---
title: Object Oriented Bize Ne Gibi Yenilikler Getirdi?
tags:
  - OO
  - C
  - C++
lang: tr
date: 2018-03-23 00:14:41
---

Genel olarak bütün dillere baktığımız üç ana kısıma ayrılıyor,
- Structured
- Object Oriented
- Functional

Ortaya çıkış sürelerine baktığımız zaman birbirlerine oldukça yakın olarak 1950-1960 civarında ortaya çıktı fakat son bir kaç yılda OO dillerin popüleritesi ve genel çevre tarafından görmüş olduu destek diğer bütün yapılara nazaran kat be kat arttı.
Özellikle C++, C# ve Java gibi dillerin sunmuş olduğu bu olanaklar programcıların aklını çelmekte kendi içinde bir gruplaşmalara bile sebep olmakta.

Peki OO dillerin bize tam olarak vaat ettiği nedir? Neden bizim için bu kadar önemli, kolay ve kullanışlılar. 
Bir çok farklı kişi buna farklı cevaplar verebilir. **Objeleri daha iyi yönetebilmek**, **gerçek dünyayı simule edebilmek**, **daha iyi yapılar oluşturabilmek** vs gibi bu liste uzayıp gider. Fakat OO dillerin aslında çözüm olarak sunduğu şeyler 3 tanedir. 
- **Encapsulation**
- **Polymorphism**
- **Inheritance**

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
Kısacası nesnelerin birbiri yerine kullanılabilmesidir. Fark edelim bir elimizde belli bir kaynaktan veri okuyup bunu işleyen bir komuz var. Bu kaynakta bir dosya olsun. Eğer kodunuzu bu dosya formatına göre yazarsanız emin olun günün birinde çıkıpta daha farklı bir dosyadan, belkide bir web sitesinden veriyi okumanızı isteyecek. Bu durumda bir çok yeri değiştirmek yerine daha işin başında sınıfınızı yada işlem yapan metodu soyutlarsanız yeni özellik eklemeniz zahmetsiz olacaktır. Bunuda  interface/abstract sınıf aracılığı ile yada function pointer ile yapmanız gerekmektedir.. OO dil kullananların oldukça aşina olduğu bir durumdur. İşin gerçeği bunu c ilede rahatlıkla yapabilirsiniz.

{% codeblock lang:cpp %}
// myapi.h
struct MY_API {
    int(*calc)(int a, int y);
    void(*info)();
};

struct MY_API create_sum_calculator();
struct MY_API create_sub_calculator();

void calculate(struct MY_API api, int a, int b);
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

void calculate(struct MY_API api, int a, int b)
{
    api.info();
    printf("2 + 5 = %i\r\n", api.calc(2,5));
}
{% endcodeblock %}

{% codeblock lang:cpp %}
// main.c
#include "Animal.h"
int main()
{
    struct MY_API sumCalc = create_sum_calculator();
    struct MY_API subCalc = create_sub_calculator();
    
    calculate(sumCalc, 2, 5);
    calculate(subCalc, 2, 5);
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
Ayrıca c++ arkaplanında buna benzer bir mekanizma kullanmaktadır. Virtual olarak tanımladığınız metodlar vtable(virtual method table) isimli bir yerde tutulur ve çağrım yağtığınızda fonksiyon bilgisi okunarak çalıştırılır. Yani c++ bu işlemleri sizin yerinize otomatik olarak yapar. Bu da hata yapma ihtimalinizi azaltır.

## Inheritance
Bir nesnenin metod yada değişkenlerinin bir başka nesne tarafından katılım yolu ile alarak kendi içerisinde barındırıyormuş gibi kullanılmasını sağlamak için kullanılmakta. Diğer kısımlarda söylemiş olduğum bu c içerisinde kolaylıkla kullanılabilir durumu ne yazık ki burada yok. Bu konuda farklı yöntemler var ama hiç biri tam olarak OO dillerde ki gibi esneklik sağlamıyor.

Aşağıda ki yöntem çok tercih edilmesede benzer bir yöntem uygulanabilir.
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

Evet bu o kadarda abstract sınıf kullanmaya benzemiyor. Farklı bir örnek ile devam edelim.

{% codeblock lang:cpp %}
//source.h
struct source;

struct source_ops
{
    int (*get)(void* ptr);
    void(*put)(void* ptr, int data);
    void(*destroy)(void*);
};

struct source* create_source(struct source_ops* ops, void* ptr);
int source_get(struct source* s);
void source_put(struct source* s, int data);
void source_delete(struct source* s);
{% endcodeblock %}

{% codeblock lang:cpp %}
//source.c
#include "source.h"

struct source
{
    struct source_ops* ops;
    void* data;
};

struct source* create_source(struct source_ops* ops, void* ptr)
{
    struct source* s = (struct source*)malloc(sizeof(struct source));
    s->data = ptr;
    s->ops = ops;
    return s;
}

int source_get(struct source* s)
{
    return s->ops->get(s->data);
}

void source_put(struct source* s, int data)
{
    s->ops->put(s->data, data);
}

void source_delete(struct source* s)
{
    s->ops->destroy(s->data);
    free(s);
}
{% endcodeblock %}

{% codeblock lang:cpp %}
//tmp_source.h
#include "source.h"
struct tmp_source {
    int* datas;
    int datas_len;
    int index;
};

struct source* create_tmp_source(int* data, int len);
int tmp_source_get(void* ptr);
void tmp_source_put(void* ptr, int data);
{% endcodeblock %}

{% codeblock lang:cpp %}
//tmp_source.c
#include "tmp_source.h"

struct source* create_tmp_source(int* data, int len)
{
    struct tmp_source* s = (struct tmp_source*)std::malloc(sizeof(struct tmp_source));
    s->index = 0;
    s->datas = data;
    s->datas_len = len;

    static struct source_ops ops = {
        tmp_source_get,
        tmp_source_put,
        free
    };

    return create_source(&ops, s);
}

int tmp_source_get(void* ptr)
{
    struct tmp_source* t = (struct tmp_source*)ptr;
    if (t->index >= t->datas_len)
        t->index = 0;

    int item = t->datas[t->index++];
    return item;
}

void tmp_source_put(void* ptr, int data)
{
    struct tmp_source* t = (struct tmp_source*)ptr;
    if (t->index >= t->datas_len)
        t->index = 0;

    t->datas[t->index++] = data;
}
{% endcodeblock %}

{% codeblock lang:cpp %}
//main.c
#include "source.h"
#include "tmp_source.h"
int main() {
    int* data = (int*)std::malloc(sizeof(int) * 255);

    for(int i = 0; i < 255; ++i)
        data[i] = i;

    struct source* s = create_tmp_source(data, 255);

    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    std::cout << "item -> " << source_get(s) << std::endl;
    return 0;
}
{% endcodeblock %}

Sonuç:
{% codeblock lang:cpp %}
item -> 0
item -> 1
item -> 2
item -> 3
item -> 4
item -> 5
item -> 6
item -> 7
{% endcodeblock %}

Ana sınıf tanımlaması için farklı bir yöntemde aşağıda.
{% codeblock lang:cpp %}
struct base {
    int x;
    int y;
};

struct derived {
    struct base base;
    int z;
};

int main() {
    struct derived d;

    d.base.x = 1;
    d.base.y = 2;
    d.z = 3;

    printf("x=%i, y=%i, z=%i\r\n", d.base.x, d.base.y, d.z);
    return 0;
}
{% endcodeblock %}

Evet ne kadar çok üzerinde çalışırsak çalışalım tam olarak inheritence mantığını uygulamak kolay olmuyor. Son örneğimizde kapsüllemeden ödün vermek zorunda kaldık. Bu da oldukça önemli bir durum. 

C++ ilk geliştirildiği zaman makine koduna derleme yapmak yerine C diline çıktı verip, c kodu olarak derlenmekteydi. Tabi o zamanlarda ki C++ ve C şu andakinden oldukça farklıydı. Özellikle C++'ın yetkinlikleri oldukça arttı. 

### Peki bütün bunlar zaten var ise bize ne gibi bir faydası dokundu?
- Öncelikle daha güvenli bir geliştirme ortamı sağladı. Üst kısımda göstermiş olduğum bir çok şeyde hata yapma riski yüksek ve eğer hata yapılırsa bulunmasıda zor.
- Yazılım geliştirmeyi daha kolay hale getirdi.
- Nesneler arasında ki ikişki ve iletişimi daha anlaşılır kıldı.
- Kalıtım sistemini çok daha doğru olarak kullanılmasını sağladı.
Eminim ki daha bir çok faydası var fakat hepsini sıralamak olanaksız.

OO diller bize vaat ettiği kadar yenilik sunmasada sağlamış olduğu esneklik bile kullanımı için yeterli. Her ne kadar c dilinin özelliklerinden bol bol bahsetsemde, şu anda projelerimde yoğun olarak c++ ve c# kullanıyorum. Bir yazılımcı olarak ilk tercihim her zaman OO dillerden birisi olacaktır :)

**NOT: örnek kodlar tamamen test amaçlıdır, ondan dolayı memory management yada bug'lar önemsenmemiştir. **

