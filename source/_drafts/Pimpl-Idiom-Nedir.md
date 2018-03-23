---
title: Pimpl Idiom Nedir?
tags:
---
Bir {% post_link object-oriented-bize-ne-gibi-yenilikler-getirdi "önce ki" %} yazıda OO dillerin iddialarından birisinin de kapsülleme özelliğinin olduğunu söylemiştik. Fakat tam olarak c dilinde ki gibi mükemmel bir sonuç elde edemediğimizi ve bunun için access modifiers(public, private, protected) kullanılması gerektiğinden bahsetmiştik. İşin kötü tarafı bunları kullanmak belli bir oradanda sorunu çözsede header dosyasında bir düzenleme yaptığınız taktirde bunu referans alan diğer bütün kodlar zincirleme olarak tekrardan derlenmesine neden oluyor. En basitinden bir değişken bile eklemiş olsanız diğer dosyalarında derlenmesi gerekiyor. Eğer merkezi konumda ki bir dosyanızda düzenleme yaptıysanız ve projeniz büyük ise bu gerçektende can sıkıcı oluyor. Bu tarz durumlardan kurtulmak için tam bir yalıtılmışlık sağlamak için bütün görünür olan değişkenlerinizin header dosyasında gizlemeye ihtiyacınız oluyor. Bu soruna çözüm seçeneklerinden birisi **Pimpl Idiom**'dur.
private implementation
Forward declaration ile kullandığınız private methodları, değişkenleri gizleyebilirsiniz.