---
title: Pimpl Idiom Nedir?
tags:
  - pimpl
  - c++
  - object-oritented
lang: tr
date: 2018-03-24 12:11:33
---

Bir {% post_link object-oriented-bize-ne-gibi-yenilikler-getirdi "önce ki" %} yazıda OO dillerin iddialarından birisinin de kapsülleme özelliğinin olduğunu söylemiştik. Fakat tam olarak c dilinde ki gibi mükemmel bir sonuç elde edemediğimizi ve bunun için access modifiers(public, private, protected) kullanılması gerektiğinden bahsetmiştik. İşin kötü tarafı bunları kullanmak belli bir oranda sorunu çözsede header dosyasında bir düzenleme yaptığınız taktirde bunu referans alan diğer bütün kodlar zincirleme olarak tekrardan derlenmesine neden oluyor. En basitinden bir değişken bile eklemiş olsanız diğer dosyalarında derlenmesi gerekiyor. Eğer merkezi konumda ki bir dosyanızda düzenleme yaptıysanız ve projeniz büyük ise bu gerçektende can sıkıcı oluyor. Bu tarz durumlardan kurtulmak için tam bir yalıtılmışlık sağlamak için bütün görünür olan değişkenlerinizin header dosyasında gizlemeye ihtiyacınız oluyor. Bu soruna çözüm seçeneklerinden birisi **Pimpl Idiom**'dur.
Pimpl Idiom ile kullanmanız gereken bütün private fonksiyon ve değişkenlerinizi başka bir class içerisine taşıyıp sadece cpp dosyası içerisinde tanımlamalarını yapıyorsunuz. Header içerisinde ise sadece horward declaration ile böyle bir sınıfınızın olduğunu belirtiyorsunuz, fakat bunun dışında içeriği konusunda hiçbir bilgi vermiyorsunuz.
Örnek olarak aşağıda ki gibi bir sınıfınızın olduğunu varsayalım.
{% gist erhanbaris/b63375f88be3cc1be025b976f55b838a AppServer_v1.hpp %}

Örnek olarak isteklerin cachelenmesi için bir düzenleme yaptığınız takdirde bunu private olarak eklerseniz önceden de bahsettiğim gibi referanslarında derlenmesi gerekecek.

{% gist erhanbaris/b63375f88be3cc1be025b976f55b838a AppServer_v2.hpp %}

Header içerisinde AppServerImpl isminde bir sınıfımızın olduğunu belirttik ve bunu AppServer içerisinde kullandığımızından bahsettik. Diğer bütün private olan şeylerimizin hepsini ortadan kaldırdık.

Bunu kullanacak olan yazılımcı/firmanın daha fazla bilgi edinmesini istemiyoruz. cpp dosyamız için tanımlamada aşağıda ki gibi olacaktır.
{% gist erhanbaris/b63375f88be3cc1be025b976f55b838a AppServer_v2.cpp %}

AppServer sınıfı için gerekli bütün private değişkenler ile private methodların hepsini AppServerImpl içerisinde tanımlıyoruz. Ayrıca AppServer pointer bilgisini AppServerImpl sınıfında tanımladım. Bunun nedeni AppServerImpl içerisinde public metod yada değişkenlere erişebilmemi sağlaması içindi.
Eğer AppServer genel yapısı üzerinde düzenleme yapmam gerekirse (ki public olanları kast etmiyorum) diğer bütün referans alan kodları derlemem gerekmeyecek.
Kodlarını ne kadar gizlerseniz o kadar kolay değişiklikler yapabilir ve zaman kazanırsınız.