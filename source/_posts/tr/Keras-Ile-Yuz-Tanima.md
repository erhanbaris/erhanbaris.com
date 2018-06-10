---
layout: posts
title: Keras İle Yüz Tanıma
tags:
  - deep learning
  - keras
  - yapay zeka
  - CNN
lang: tr
date: 2018-06-10 19:40:22
---

Bir süredir yapay zeka konuları ile ilgileniyorum. Python sayesinde bir çok sorunun basit çözümlerinin olduğunu ve bunları gerçek dünya sorunları ile örtüştürüle bileceğini görmek gerçektende keyif verici. Özellikle keras kütüphanesi yeni başlayanlar da dahil olmak üzere bir çok kişi tarafından kullanılıyor. Oldukça kolay ve esnek yapısı sayesinde neredeyse her konuda çözüm üretebiliyor.

Öncelikle kendimin tam olarak 1500 tane fotoğrafını çekip train ettirdikten sonra kamerada beni tanımasını bekledim. Ne yazık ki beklediğim gibi olmadı. Yazdığım kodu değiştirdim, gene olmadı. Nerede hata yaptığımı düşündüm durdum. Sonradan fark ettim ki beni diğer yüzlerden ayırabilmesi için ben ve diğerlerini bilmesi gerekiyor. Biraz tuhaf bir cümle oldu ama aslında tam olarak o. Yani benim fotoğraflarımı inceleyip beni tanır iken diğerlerinden ne farkımın olduğunu anlaması için diğer insanlarıda incelemesi ve benim farklılıklarımı tespit etmesi gerekiyordu. Bende kendi fotoğraflarımın yanında başkalarınında fotoğraflarını train işlemine soktum. Evet, sonunda bir sonuç elde etmeye başladım. Beni tanımaya başladı ama tam olarak istediğim gibi olmasa bu da bir çözümdü. Sonradan birkaç düzenleme ile birlikte çok daha iyi sonuçlar elde ettim.
Şimdi gelelim bu işlemler nasıl oldu ve nasıl ilerledim.

Öncelikle kameradan görüntü almak gerekiyor. Bir çok kütüphane olsada aralarında en iyisi OpenCV birinci tercihim oldu. Fotoğrafları düzenlemek, işlemek için skimage kullanmayı uygun gördüm. sklearn ile gerekli araç gereçler için kullandım ve tabikide tahmin işlemleri için keras kullandım.

{% gist f6846e6a440ac75f3cd0a5024e6e4077 pip_install %}

Gerekli olan bütün eklentileri kurduğumuza göre artık işlemlerimize devam edebiliriz.
Elimizde bir dataset yok ve acil olarak bunu oluşturmamız gerekiyor. Bunun içinde anlık olarak kameradan görüntü alıp bunları kullanabiliriz.
İnternette OpenCV ile kameradan görüntü almak için bir çok kod var. Benim ki de onlardan çok farklı değil.

{% gist f6846e6a440ac75f3cd0a5024e6e4077 OpenCV_camera.py %}

frame bizim fotoğraf değişkenimiz. frame değişkeninin tipi numpy array ve bu bizim bir çok iş yapmaktan kurtaracak. Kameradan aldığımız görüntüleri arka arkaya kayıt ederek dataset oluşturacağız. Bir çok kişiden kayıtlar alıp bunları klasörleyip kullanacağız. Fakat bu fotoğrafların boyutlarının çok büyük olması train işlemini yavaşlatacak ve çıkmaza sokacak bir durum. Tabi elinizde kullanabileceğiniz bir GPU varsa o başka.
Fotoğrafları 300 * 300 pixel boyutlarında kullanmayı tercih ediyorum.

{% gist f6846e6a440ac75f3cd0a5024e6e4077 OpenCV_camera_2.py %}

img klasörünün içerisine **erhan**, **aysel**, **ilker**, **bulent**, **omer** ve **guleser** isimli klasörler açarak kamerada bu kişilerin tek tek fotoğraflarını çekiyoruz. Her enter tuşuna basışımızda bir sonra ki kişinin fotoğrafları çekiliyor. Bunları siz istediğiniz gibi düzenleyin.
Böylelikle elimizde tam olarak 7500 tane fotoğraf var ve artık asıl işimize geri dönebiliriz.
Öncelikle keras'ta Dense layer kullandım ama istediğim sonuçlara bir türlü ulaşamadım. Zaten görüntü işlemede **CNN** oldukça yaygın olarak kullanılan bir nöron ağı. Nöron ağımızı oluşturmaya ve dataset'imizi train ettirmeye artık başlayabiliriz.

{% gist f6846e6a440ac75f3cd0a5024e6e4077 cnn.py %}

**Train on 4410 samples, validate on 1890 samples
Epoch 1/2
2018-06-10 16:02:31.728099: I tensorflow/core/platform/cpu_feature_guard.cc:140] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA
4410/4410 [==============================] - 313s 71ms/step - loss: 0.3760 - acc: 0.8565 - val_loss: 0.0137 - val_acc: 0.9958
Epoch 2/2
4410/4410 [==============================] - 307s 70ms/step - loss: 0.0468 - acc: 0.9850 - val_loss: 0.0108 - val_acc: 0.9958
2700/2700 [==============================] - 75s 28ms/step**

Test sonuçları oldukça güzel görünüyor.
**Test Acc : 0.9951851851851852**
**Test Loss : 0.010227037012615863**

Kameradan anlık olarak görüntü alıp bunu kontrol ettirebiliriz. Test sonuçları çok iyi olsada gerçekte bu kadar başarılı olamayabiliyor. Üzeride biraz daha çalışılarak daha iyi sonuçlar elde edilebilir fakat şu an için buna gerek yok.
Bulmacanın eksik kalan parçalarınıda koyup kodu toparlamanın zamanı geldi.

{% gist f6846e6a440ac75f3cd0a5024e6e4077 final.py %}

Üst kısımda yaptıklarımızı biraz daha topladık ve artık çalışan bir kodumuz oldu. Uygulamayı çalıştırdığımızda karenin ortasına kafamızı yerleştirip önce fotoğrafları kayıt ediyoruz sonrasında train işlemi yaplıyor ve bütün bunlar bittikten sonra da kırmızı çizgilerin içerisine kafamızı yerleştirip tahmin etmesini izliyoruz.
Benim için oldukça eğitici ve ilginç bir uygulama oldu. Umarım sizinde hoşunuza gitmiştir. Bu arada fotoğrafları siyah beyaz olarak kullandığımızı söylemeyi unutmuşm. Zira işleri kısaltmak ve bilgisayarları yormamak istedim.

Ve bu kadar emeğimizin sonucu :)

{% asset_path images %} 
{% asset_img "yuz_tanima.png" "Keras ile yüz tanıma" %}